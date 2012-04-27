

  Deploy on heroku:

  wget -qO- https://toolbelt.heroku.com/install.sh | sh
  heroku login
  heroku create --stack cedar
  git push heroku master
  heroku run rake db:migrate
