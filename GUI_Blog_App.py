import tkinter as tk
from tkinter import messagebox
import mysql.connector
from datetime import datetime

# MySQL connection
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="root123",
    database="blog_site"
)
cursor = db.cursor()


#############################################################################################################################



class BlogApp:

    def __init__(self, root):
        self.root = root
        self.root.title("Blog Site")
        self.user_id = None

        # login/register frame
        self.create_login_frame()

    #############################################################################################################################

    def create_login_frame(self):
        self.frame_login_register = tk.Frame(self.root)
        self.frame_login_register.pack(padx=20, pady=20)
        
        tk.Label(self.frame_login_register, text="Blog Site Login", font=("Arial", 16)).grid(row=0, column=0, columnspan=2, pady=10)
        
        tk.Label(self.frame_login_register, text="SRN:").grid(row=1, column=0, sticky='e', padx=5)
        self.entry_srn = tk.Entry(self.frame_login_register, width=30)
        self.entry_srn.grid(row=1, column=1, padx=5, pady=5)
        
        tk.Label(self.frame_login_register, text="Password:").grid(row=2, column=0, sticky='e', padx=5)
        self.entry_password = tk.Entry(self.frame_login_register, show="*", width=30)
        self.entry_password.grid(row=2, column=1, padx=5, pady=5)
        
        tk.Button(self.frame_login_register, text="Login", command=self.login).grid(row=3, column=0, padx=5, pady=10)
        tk.Button(self.frame_login_register, text="Register", command=self.register_window).grid(row=3, column=1, padx=5, pady=10)

    #############################################################################################################################


    def login(self):
        srn = self.entry_srn.get()
        password = self.entry_password.get()
        
        cursor.execute("SELECT USER_ID FROM USER WHERE SRN=%s AND PASSWORD=%s", (srn, password))
        result = cursor.fetchone()
        
        if result:
            self.user_id = result[0]
            self.frame_login_register.pack_forget()
            self.main_menu()
        else:
            messagebox.showerror("Error", "Invalid SRN or Password")


    #############################################################################################################################


    def register_window(self):
        self.frame_login_register.pack_forget()
        
        self.frame_register = tk.Frame(self.root)
        self.frame_register.pack(padx=20, pady=20)

        tk.Label(self.frame_register, text="User Registration", font=("Arial", 16)).grid(row=0, column=0, columnspan=2, pady=10)

        registration_fields = [
            ("Name:", "entry_name"),
            ("SRN:", "entry_srn_reg"),
            ("Phone No:", "entry_phone"),
            ("Email:", "entry_email"),
            ("Password:", "entry_password_reg")
        ]

        for i, (label_text, entry_name) in enumerate(registration_fields):
            tk.Label(self.frame_register, text=label_text).grid(row=i+1, column=0, sticky='e', padx=5)
            entry = tk.Entry(self.frame_register, width=30)
            entry.grid(row=i+1, column=1, padx=5, pady=5)
            setattr(self, entry_name, entry)

        # Modify password entry to show asterisks
        self.entry_password_reg = tk.Entry(self.frame_register, show="*", width=30)
        self.entry_password_reg.grid(row=6, column=1, padx=5, pady=5)

        tk.Button(self.frame_register, text="Register", command=self.register).grid(row=7, column=0, columnspan=2, pady=10)
        tk.Button(self.frame_register, text="Back to Login", command=self.back_to_login).grid(row=8, column=0, columnspan=2)


    #############################################################################################################################


    def back_to_login(self):
        # Common method to return to login screen from various frames
        try:
            self.frame_register.pack_forget()
        except:
            pass
        try:
            self.frame_main.pack_forget()
        except:
            pass
        try:
            self.frame_create_post.pack_forget()
        except:
            pass
        try:
            self.frame_delete_post.pack_forget()
        except:
            pass
        try:
            self.frame_view_posts.pack_forget()
        except:
            pass
        try:
            self.frame_comment_post.pack_forget()
        except:
            pass
        try:
            self.frame_like_post.pack_forget()
        except:
            pass
        
        self.create_login_frame()

    
    #############################################################################################################################

    def register(self):
        name = self.entry_name.get()
        srn = self.entry_srn_reg.get()
        phone = self.entry_phone.get()
        email = self.entry_email.get()
        password = self.entry_password_reg.get()

        cursor.execute("INSERT INTO USER (NAME, SRN, PHONE_NO, EMAIL, PASSWORD) VALUES (%s, %s, %s, %s, %s)",
                       (name, srn, phone, email, password))
        db.commit()
        
        messagebox.showinfo("Success", "Registration successful")
        self.frame_register.pack_forget()
        self.create_login_frame()


    #############################################################################################################################


    def main_menu(self):
        self.frame_main = tk.Frame(self.root)
        self.frame_main.pack(padx=20, pady=20)

        tk.Label(self.frame_main, text="Blog Site Menu", font=("Arial", 16)).grid(row=0, column=0, columnspan=2, pady=10)

        menu_buttons = [
            ("Create Post", self.create_post_window),
            ("Delete Post", self.delete_post_window),
            ("View Posts", self.view_posts_window),
            ("Comment on Post", self.comment_post_window),
            ("Like Post", self.like_post_window),
            ("Logout", self.back_to_login)
        ]

        for i, (text, command) in enumerate(menu_buttons):
            tk.Button(self.frame_main, text=text, command=command, width=20).grid(row=i+1, column=0, padx=10, pady=5)


    #############################################################################################################################


    def create_post_window(self):
        self.frame_main.pack_forget()
        self.frame_create_post = tk.Frame(self.root)
        self.frame_create_post.pack(padx=20, pady=20)

        tk.Label(self.frame_create_post, text="Create New Post", font=("Arial", 16)).grid(row=0, column=0, columnspan=2, pady=10)

        tk.Label(self.frame_create_post, text="Title:").grid(row=1, column=0, sticky='e', padx=5)
        self.entry_post_title = tk.Entry(self.frame_create_post, width=40)
        self.entry_post_title.grid(row=1, column=1, padx=5, pady=5)

        tk.Label(self.frame_create_post, text="Content:").grid(row=2, column=0, sticky='ne', padx=5)
        self.entry_post_content = tk.Text(self.frame_create_post, height=5, width=40)
        self.entry_post_content.grid(row=2, column=1, padx=5, pady=5)

        tk.Button(self.frame_create_post, text="Create Post", command=self.create_post).grid(row=3, column=1, pady=10)
        tk.Button(self.frame_create_post, text="Back to Home", command=self.back_to_main_menu).grid(row=4, column=1)


    #############################################################################################################################



    def back_to_main_menu(self):
        # Hide current frame and return to main menu
        try:
            self.frame_create_post.pack_forget()
        except:
            pass
        try:
            self.frame_delete_post.pack_forget()
        except:
            pass
        try:
            self.frame_view_posts.pack_forget()
        except:
            pass
        try:
            self.frame_comment_post.pack_forget()
        except:
            pass
        try:
            self.frame_like_post.pack_forget()
        except:
            pass
        
        self.main_menu()


    #############################################################################################################################


    def create_post(self):
        title = self.entry_post_title.get()
        content = self.entry_post_content.get("1.0", tk.END).strip()

        if not title or not content:
            messagebox.showerror("Error", "Title and content cannot be empty")
            return

        cursor.execute("INSERT INTO POST (TITLE, CONTENT, USER_ID, POST_DATE) VALUES (%s, %s, %s, %s)",
                       (title, content, self.user_id, datetime.now()))
        db.commit()
        messagebox.showinfo("Success", "Post created successfully")
        self.frame_create_post.pack_forget()
        self.main_menu()


    #############################################################################################################################


    def delete_post_window(self):
        self.frame_main.pack_forget()
        self.frame_delete_post = tk.Frame(self.root)
        self.frame_delete_post.pack(padx=20, pady=20)

        tk.Label(self.frame_delete_post, text="Delete Post", font=("Arial", 16)).grid(row=0, column=0, columnspan=2, pady=10)

        tk.Label(self.frame_delete_post, text="Post ID:").grid(row=1, column=0, sticky='e', padx=5)
        self.entry_delete_post_id = tk.Entry(self.frame_delete_post, width=30)
        self.entry_delete_post_id.grid(row=1, column=1, padx=5, pady=5)

        tk.Button(self.frame_delete_post, text="Delete Post", command=self.delete_post).grid(row=2, column=1, pady=10)
        tk.Button(self.frame_delete_post, text="Back to Home", command=self.back_to_main_menu).grid(row=3, column=1)

    
    #############################################################################################################################


    def delete_post(self):
        post_id = self.entry_delete_post_id.get()
        
        # Check if post belongs to the current user
        cursor.execute("SELECT COUNT(*) FROM POST WHERE POST_ID=%s AND USER_ID=%s", (post_id, self.user_id))
        if cursor.fetchone()[0] == 0:
            messagebox.showerror("Error", "Post not found or you don't have permission to delete")
            return

        cursor.execute("DELETE FROM POST WHERE POST_ID=%s AND USER_ID=%s", (post_id, self.user_id))
        db.commit()
        messagebox.showinfo("Success", "Post deleted successfully")
        self.frame_delete_post.pack_forget()
        self.main_menu()


    #############################################################################################################################


    def view_posts_window(self):
        self.frame_main.pack_forget()
        self.frame_view_posts = tk.Frame(self.root)
        self.frame_view_posts.pack(padx=20, pady=20)

        tk.Label(self.frame_view_posts, text="View Posts", font=("Arial", 16)).grid(row=0, column=0, columnspan=2, pady=10)

        tk.Label(self.frame_view_posts, text="User Name/SRN:").grid(row=1, column=0, sticky='e', padx=5)
        self.entry_view_posts_user = tk.Entry(self.frame_view_posts, width=30)
        self.entry_view_posts_user.grid(row=1, column=1, padx=5, pady=5)

        tk.Button(self.frame_view_posts, text="View Posts", command=self.view_posts).grid(row=2, column=1, pady=10)
        tk.Button(self.frame_view_posts, text="Back to Home", command=self.back_to_main_menu).grid(row=3, column=1)


    #############################################################################################################################


    def view_posts(self):
        user_info = self.entry_view_posts_user.get()
        cursor.execute("SELECT POST_ID, TITLE, CONTENT, POST_DATE FROM POST JOIN USER ON POST.USER_ID=USER.USER_ID WHERE USER.SRN=%s OR USER.NAME=%s", (user_info, user_info))
        
        posts = cursor.fetchall()
        if not posts:
            messagebox.showinfo("Posts", "No posts found for this user.")
            return

        # display posts
        posts_window = tk.Toplevel(self.root)
        posts_window.title(f"Posts by {user_info}")
        posts_window.geometry("500x400")

        text_widget = tk.Text(posts_window, wrap=tk.WORD)
        text_widget.pack(padx=10, pady=10, fill=tk.BOTH, expand=True)

        for post in posts:
            text_widget.insert(tk.END, f"Post ID: {post[0]}\n")
            text_widget.insert(tk.END, f"Title: {post[1]}\n")
            text_widget.insert(tk.END, f"Content: {post[2]}\n")
            text_widget.insert(tk.END, f"Date: {post[3]}\n")
            text_widget.insert(tk.END, "-" * 50 + "\n")

        text_widget.config(state=tk.DISABLED)  


    #############################################################################################################################


    def comment_post_window(self):
        self.frame_main.pack_forget()
        self.frame_comment_post = tk.Frame(self.root)
        self.frame_comment_post.pack(padx=20, pady=20)

        tk.Label(self.frame_comment_post, text="Comment on Post", font=("Arial", 16)).grid(row=0, column=0, columnspan=2, pady=10)

        tk.Label(self.frame_comment_post, text="Post ID/Title:").grid(row=1, column=0, sticky='e', padx=5)
        self.entry_comment_post_id = tk.Entry(self.frame_comment_post, width=30)
        self.entry_comment_post_id.grid(row=1, column=1, padx=5, pady=5)

        tk.Label(self.frame_comment_post, text="Comment Content:").grid(row=2, column=0, sticky='ne', padx=5)
        self.entry_comment_content = tk.Text(self.frame_comment_post, height=3, width=40)
        self.entry_comment_content.grid(row=2, column=1, padx=5, pady=5)

        tk.Button(self.frame_comment_post, text="Add Comment", command=self.comment_post).grid(row=3, column=1, pady=10)
        tk.Button(self.frame_comment_post, text="Back to Home", command=self.back_to_main_menu).grid(row=4, column=1)


    #############################################################################################################################


    def comment_post(self):
        post_identifier = self.entry_comment_post_id.get()
        comment_content = self.entry_comment_content.get("1.0", tk.END).strip()

        if not comment_content:
            messagebox.showerror("Error", "Comment cannot be empty")
            return

        cursor.execute("SELECT POST_ID FROM POST WHERE POST_ID=%s OR TITLE=%s", (post_identifier, post_identifier))
        post = cursor.fetchone()
        
        if post:
            cursor.execute("INSERT INTO COMMENT (COMMENT_CONTENT, USER_ID, POST_ID) VALUES (%s, %s, %s)",
                           (comment_content, self.user_id, post[0]))
            db.commit()
            messagebox.showinfo("Success", "Comment added successfully")
        else:
            messagebox.showerror("Error", "Post not found")
        
        self.frame_comment_post.pack_forget()
        self.main_menu()


    #############################################################################################################################


    def like_post_window(self):
        self.frame_main.pack_forget()
        self.frame_like_post = tk.Frame(self.root)
        self.frame_like_post.pack(padx=20, pady=20)

        tk.Label(self.frame_like_post, text="Like Post", font=("Arial", 16)).grid(row=0, column=0, columnspan=2, pady=10)

        tk.Label(self.frame_like_post, text="Post ID/Title:").grid(row=1, column=0, sticky='e', padx=5)
        self.entry_like_post_id = tk.Entry(self.frame_like_post, width=30)
        self.entry_like_post_id.grid(row=1, column=1, padx=5, pady=5)

        tk.Button(self.frame_like_post, text="Like Post", command=self.like_post).grid(row=2, column=1, pady=10)
        tk.Button(self.frame_like_post, text="Back to Home", command=self.back_to_main_menu).grid(row=3, column=1)


    #############################################################################################################################


    def like_post(self):
        post_identifier = self.entry_like_post_id.get()
        
        cursor.execute("SELECT POST_ID FROM POST WHERE POST_ID=%s OR TITLE=%s", (post_identifier, post_identifier))
        post = cursor.fetchone()
        
        if post:
            # Check if user has already liked the post
            cursor.execute("SELECT COUNT(*) FROM POST_LIKES WHERE POST_ID=%s AND USER_ID=%s", (post[0], self.user_id))
            if cursor.fetchone()[0] > 0:
                messagebox.showwarning("Warning", "You have already liked this post")
                self.frame_like_post.pack_forget()
                self.main_menu()
                return

            cursor.execute("INSERT INTO POST_LIKES (POST_ID, USER_ID, TIME_OF_LIKE) VALUES (%s, %s, %s)",
                           (post[0], self.user_id, datetime.now()))
            
            # Update post likes count
            cursor.execute("UPDATE POST SET NO_OF_LIKES = NO_OF_LIKES + 1 WHERE POST_ID = %s", (post[0],))
            
            db.commit()
            messagebox.showinfo("Success", "Post liked successfully")
        else:
            messagebox.showerror("Error", "Post not found")
        
        self.frame_like_post.pack_forget()
        self.main_menu()
    

    #############################################################################################################################


root = tk.Tk()
root.geometry("400x500")  # default window size
app = BlogApp(root)
root.mainloop()