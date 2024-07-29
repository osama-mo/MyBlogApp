# MyBlogApp

## Overview

MyBlogApp is a mobile application developed using Flutter with a backend powered by Django. This app allows users to sign in, sign up, add new blogs, and view existing blogs. The app is designed using the Clean Architecture pattern to ensure maintainability and scalability.



## Flutter App

### Features
- **Sign In / Sign Up Pages**: Users can create an account or log in to an existing one.
- **Store Current User Token**: The user token is stored locally using Shared Preferences for maintaining session state.
- **Add New Blog**: Authenticated users can create new blog posts, including uploading images.
- **Blog Home Page**: Displays all the blogs available to the user.



### Flutter Technologies Used
- **Shared Preferences**: For local storage of user tokens.
- **Bloc**: State management for handling the app's state and business logic.
- **GetIt**: Dependency injection to manage app dependencies efficiently.

### Architecture
The application follows the Clean Architecture pattern, organized as follows:
- **Features**: Contains three layers for each feature: Data , Domain , Presentation .
- **Core**: Includes the essential utilities and common code used across all features.

- 
![til](./tree/main/client/blog_app/app.png)

## Django Backend
- **PostgreSQL Database**: Utilized for persistent data storage.
- **HTTP Endpoints**:
  - **Sign In**: Authenticates users and returns an access token.
  - **Sign Up**: Registers new users.
  - **Get All Users**: Retrieves a list of all users.
  - **Get User by Token**: Fetches user details using the access token.
  - **Create New Blog**: Allows authenticated users to create new blog posts with image upload capability.
  - **Get All Blogs**: Retrieves all blog posts; this endpoint requires an access token for access.
