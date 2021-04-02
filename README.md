# Umanni Fullstack developer test
---------------------------

## Porject dependencies

* Ruby 3.0.0
* Rails 6.1.3
* Bundler 2.2.15
* Docker 20.10.3
* Docker-compose 1.27.4
* Postgresql 12
* Redis 5.0

## Project setup

* `$ git clone --branch fullstack-dev-test https://github.com/hugohernani/Fullstack-Developer`
* `$ cd Fullstack-Developer`
* `$ cp .env.sample .env`

### Local setup

* `$ bundle install`
* `$ yarn install`
* `$ bundle exec rake db:create db:migrate db:seed`

### Docker setup

* `$ docker-compose build`
* `$ docker-compose run web db:create db:migrate db:seed`

## Running the project

### Without docker

* `$ bundle exec rails s`

### With docker

* `$ docker-compose up`


## Some Features

- System creates two users when running db:seed:
 - `admin@localhost.com` and `member@localhost.com`
 - Check their password on seeds and environment file (`.env`)

### Real-time

- Some functionalities were built using real-time communication:
 - Toggling an user on Users listing view and Users detail view is made through ActionCable and through broadcast calls

- User Bulk upload progress is updated when bulk file is being processed. The algorithm uses an observer to be notified when an update should happen and once it's called it broadcasts changes to browser clients. Then clients updates their progress bar according to the received data.

### Validations

- Validations is done both on client and server sides. Validation errors are loaded from server to keep consistency on data information

### Drag and Drop

- Avatar upload and Bulk Upload can be done by clicking on the upload are or dragging and dropping a file on it.


### Direct Upload

- Uploading files (avatar image or bulk file) are done through direct upload (file is uploaded directly to server before form is submitted)
-- This is handled by a `stimulus` controller (check `app/javascript/controllers` path)
