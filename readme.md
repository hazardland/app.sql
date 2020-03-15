PostgreSQL Database Template
-----------------------------

Whenever starting a small/medium project it is wise to have some database template because every time you waste time on a task similar to which you have solved in the past you are getting a bit dumber.

Repository is centred around solving user account related tasks and uses stored procedures and triggers for a common challanges. It is divided as a site and admin databases.

### Site database
* **User account** - users
  * When user is record is inserted following happens:
    * User profile is created
    * User email verification token is generated
    * Welcome email is sheduled containing email confirmation token
  * When user email is changed:
    * New email confirmation token is generated
    * Email confirmation token is sent
    * Old email is stored in user history
  * When password is changed:
    * Password change is logged

* **User profile** - user_profile
  * User profile is created automatically once a record is inserted in users table

* **User auth session** - user_session
  * While having auth session tokens in a table is not what you might see in a large projects but for starters it is just right.

* **User's one time tokens** - user_token, user_token_config
  * For verifying emails, Recovering passwords, etc
  * You issue token, using sql function and validate it using sql function also, there is no need to write extra code everytime you start a new project in a new language.

* **Sending email and email templates** - sendmail, sendmail_template
  * As sending mail must be async task and we need it while registering user, regenerating email confirmation token and recovering passwords. A sendmail function is used to send mails (insert into sendmail table). Mail templates are predefined, they include tags which should be replaced before sending email.

* User media (For uploading files) - user_media
  * You should provide user media like images with static link instead of exposing media_id. To generated static link with an algorithm you need some hashing using image_id and insert_date(something nobody knows) unless they have your database and algorithm.

* User history
  * Some logging for user account


### Admin database
  * Admins - admin
  * Admin auth sessions - admin_session


## Contents
```Javascript
├───admin
│   │   schema.sql # Creates admin schema
│   │
│   └───tables
│           admin.sql # Admin table
│           admin_session.sql # Admin auth tokens
│
└───site
    │   schema.sql # Site schema
    │
    ├───functions
    │       sendmail.sql # Send mail to user with JSON payload
    │       user_email_verify.sql # Verify user email with provided token
    │       user_password_update.sql # Update user password during recovery with provided token
    │       user_token_generate.sql # Generate new one time token for user and specified type
    │       user_token_send.sql # Send token on user email (Email template from user_token_config)
    │       user_token_valid.sql # Check if user token is valid and is not expired and is not used
    │       user_token_verify.sql # Verify user token and mark as consumed
    │
    ├───tables
    │       users.sql # The thing
    │       user_profile.sql # User profile
    │       user_history.sql # User account change history
    │       user_media.sql # For uploading images, videos and audio
    │       user_session.sql # User auth session
    │       user_token.sql # User tokens
    │       user_token_config.sql # User token configs
    │       sendmail.sql # Sent mails
    │       sendmail_template.sql # Email templates where you configure subject, from, email text and etc.
    │       debug.sql
    │       chat_friend.sql
    │       chat_media.sql
    │       chat_message.sql
    │       chat_text.sql
    │
    └───triggers
            user_email_change.sql # Send new email confirmation email
            user_profile_create.sql # Create user profile after users table insert
            chat_friend_activate.sql
```
