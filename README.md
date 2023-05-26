# SUPPLY

## Description

Application for placing orders for the supply of the restaurant. The application has two users: main and administrator.

* Database: PostgreSQL 15.1
* Programming Language: Ruby (3.0.3)
* Development Framework: Ruby on Rails (7.0.3.1)
* Gems: devise, cancancan, pg, ransack, geocoder, gmaps4rails

## Installation and Setup

1. Clone the repository to your local machine.

    ```git clone {web_URL_repository}.```

2. Install the necessary dependencies by running the command:

    ```bundle install```

3. Create the PostgreSQL database and configure the database access in the ```config/database.yml``` file.

4. Run the database migrations:

    ```rails db:migrate```

5. Start the application:

    ```rails server```

6. Open your browser and navigate to http://localhost:3000 to access the application