# Socialite
![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white) ![SASS](https://img.shields.io/badge/SASS-hotpink.svg?style=for-the-badge&logo=SASS&logoColor=white) ![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white) [![Hotwire](https://img.shields.io/badge/-Hotwire-333333?style=for-the-badge&logo=hotwire&logoColor=white)](https://hotwired.dev)


**Socialite** is a social media platform built as part of the final project for The Odin Project curriculum. This app allows users to create profiles, post updates, interact with each other’s content, and manage their own social interactions.

## Features

- **User Authentication**: Powered by Devise, with GitHub login enabled via OmniAuth.
- **User Profiles**: Profiles are created automatically upon registration, with profile pictures sourced from GitHub or Gravatar.
- **Posting and Interactions**: Users can create posts, like other users’ posts, and leave comments.
- **Real-time Updates**: Using Hotwire (Turbo Frames and Turbo Streams) to dynamically update pages without full page reloads.
- **Follow System**: Users can follow and be followed, creating a network of connections.

## Tech Stack

- **Backend**: Ruby on Rails 7.1
- **Database**: PostgreSQL
- **Stylesheets**: Sass, organized with the **BEM (Block Element Modifier)** methodology for clean, maintainable CSS
- **Real-time Interactivity**: Hotwire (Turbo and Stimulus)
- **Image Management**: Active Storage with Cloudinary for image storage and `image_processing` for transformations
- **Testing**: RSpec, FactoryBot, Capybara (with Cuprite as a headless driver)

## Installation

To set up **Socialite** locally, follow these steps:

### 1. Clone the repository

```bash
git clone https://github.com/AhmedTheGreatest/socialite.git
```

### 2. Install dependencies

```bash
bundle install
yarn install
```

### 3. Set up the database

```bash
rails db:setup
```

### 4. Start the server

```bash
rails server
```

Visit `http://localhost:3000` in your browser.

---

## Configuration

This project requires some credentials to be set up through Rails encrypted credentials. These include:

- `secret_key_base` for Rails application secrets
- GitHub OmniAuth keys for GitHub OAuth login
- Cloudinary API keys for image storage
- Database URL for the production PostgreSQL connection

### Setting Up Encrypted Credentials

1. To edit Rails credentials, use the command:

```bash
EDITOR="code --wait" bin/rails credentials:edit
```

Replace `"code --wait"` with your preferred editor.

2. Inside the editor, add your credentials:

```yaml
secret_key_base: "your_secret_key_base_here"

github_omniauth:
  client_id: "your_github_client_id"
  client_secret: "your_github_client_secret"

cloudinary:
  api_key: "your_cloudinary_api_key"
  api_secret: "your_cloudinary_api_secret"
  cloud_name: "your_cloudinary_cloud_name"

database_url: "your_production_database_url"
```

3. Save and close the file. Rails will automatically encrypt and securely store these credentials.

### Environment Variables

- **`WSL`**: Set this to `true` if you are running the project on WSL.
- **`BROWSER`**: Specify the path to your Chrome or Chromium browser for Cuprite if needed.

---

## Deployment
![Render](https://img.shields.io/badge/Render-%46E3B7.svg?style=for-the-badge&logo=render&logoColor=white)
Socialite is deployed and accessible at [https://socialite-qpr1.onrender.com/](https://socialite-qpr1.onrender.com/). The app is hosted on **Render**, while the **PostgreSQL database** is hosted on **Neon**. **Cloudinary** is used for image storage.

### Additional Notes

For local development, running tests, or deploying to other environments, the standard setup in the sections above should suffice. Be sure to configure your environment variables and Rails credentials properly for secure, smooth deployment.

---

## Testing

To run tests, use:

```bash
bundle exec rspec
```

If running on WSL, make sure `WSL` is set to `true` and `BROWSER` points to your browser.
