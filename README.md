Relate
========

## Environment Variables

To keep secrets confidential, we're using environment variables set in Heroku.  You'll see stuff like this in the codebase:

    config.secret_key = ENV['DEVISE_SECRET_KEY']

That means if you just run `rails` or `rspec` you'll get something like this:

    $ rails s
    ...
    Devise.secret_key was not set. Please add the following to your Devise initializer: (RuntimeError)

      config.secret_key = '...'

    ...

So, we're using [Foreman](http://github.com/ddollar/foreman) to take care of the heavy lifting for us.  First, you'll have to put the following in a file called `.env`:

    SECRET_KEY_BASE=fake_secret_key_base
    DEVISE_SECRET_KEY=fake_devise_secret_key

(You can use the key generated in the error message above for the fake keys if you'd like, or `rake secret`.)  `.env` is ignored in `.gitignore`, so don't expect it to be under source control.

When you want to run something like `rails` or `rspec`, prepend it with `foreman run bundle exec`.  To make my life easier, I have the following aliases in my `.bashrc` file:

    alias fr="foreman run bundle exec rails"
    alias fs="foreman run bundle exec rspec"
    
Because these are also needed for precompiling assets, I've enabled Heroku's [user-env-compile](http://devcenter.heroku.com/articles/labs-user-env-compile).

## Mail

For testing mailers, I'm using [MailCatcher](http://mailcatcher.me).  I recommend you do too.  In production, we're sending mail through Heroku's [SendGrid](http://devcenter.heroku.com/articles/sendgrid) app.
