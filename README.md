[![Build Status](https://semaphoreci.com/api/v1/brentgreeff/fat_model_auth/branches/master/badge.svg)](https://semaphoreci.com/brentgreeff/fat_model_auth)

- [Example app - view installation diff](https://github.com/brentgreeff/basic_rails_5_api/commit/6f0cedff4077c1609d32567bfb889fc8fa908db7)

# FatModelAuth

Wikipedia defines Authorization as:

> “the function of specifying access rights to resources”

Fat Model Auth allows the resources themselves to define these rights.

## Install

Add to Gemfile

    $ gem fat_model_auth

## Fat Model Auth is a simple, clean authorization system for Rails

How simple?

## ArticlesController

```
before_action :load_article

def edit
end

def update
end

private

def load_article
  Article.find(params[:id])
end
```

We want to ensure only the Article's author can view the edit page or update the article.

### Add a before filter to the articles_controller:

`before_action :auth_required, only: [:edit, :update]`

Since this is the article controller, the resource in question is the @article.

auth_required must be called after the resource is already loaded.

Like this:

```
before_action :load_article, only: [:edit, :update]
before_action :auth_required, only: [:edit, :update]
```

auth_required will infer the name of the resource from the controller. In the case of articles_controller, it will look for an @article instance variable.

Try and view the articles#edit page from a browser, or event better: re-run the spec.

You should get an exception:

`undefined method 'allows' for #<Article:0x204a8d8>`

This means the gem is working correctly.

fat_model_auth has generated a call to the @article model:

`@article.allows(current_user).to_edit?`

You need to define a `current_user` method in the application_controller, so that the current user is passed in for evaluation.

If `current_user` is `nil`, the controller will always return access_denied.


## In the Article Model

* Add the following:

```
allows :edit, :update,
  if: -> (article, user) { article.author == user }
```

The article model now supports the allows instance method, with 2 chains:

`@article.allows(current_user).to_edit?`

- called from the #edit action when using the auth_required before_action.

`@article.allows(current_user).to_update?`

- called on the update action.

### Access Denied is 404

Trying to access a resource without permission returns 404.

By returning 403 (Forbidden) you might be revealing potentially sensitive information.

404 = that doesn't exist.

403 = Yes that does exist, but you need to try harder to get access to it.


### New & Create

When dealing with the #new & #create actions we need a slightly different approach.

Quite often we will build the new object in the action.

```
def create
  @article = current_user.articles.build(params[:article])
  return if access_denied?
end
```

When you call access_denied? fat_model_auth will ask the @article if access is allowed.

The following call is generated for you:

`@article.allows(current_user).to_create?`


### What if you need different rules for different actions?

```
allows :edit,
  if: -> (article, user) { article.author.can_edit? }

allows :update,
  if: -> (article, user) { article.allows_updating? }

allows :delete,
  unless: -> (article, user) { user.can_delete?(article) }
```

Both if: and unless: symbols are supported.


### What if you are loading an @article in the StoriesController

We need to tell the controller which object will act as the authority.

      class StoriesController < ApplicationController
        def override_authority
          @article
        end
      end


## View (templates)

Control which links, buttons or controls are displayed to a user:

`<%= link_to('EDIT', edit_article_path(article)) if allowed_to? edit: article -%>`


Control which blocks of html are accessible:

```
<% if allowed_to? edit_or_destroy: article -%>
  <funky>html</funky>
<% end %>
```


## Test First

Before adding unit tests, its best to start with a request_spec or another kind of integration test which is focussed on user interaction.

If the integration test covers the logic in the model then that might be sufficient.

## Request specs
```
login_as no_good_user

get "/articles/#{article.to_param}/edit"

expect( response ).to have_http_status(404)
```

If you are using a mock user, you can stub the response

```
let(:yes) { FatModelAuth::CannedGateKeeper.allows(:edit) }

it "allows"
  expect(article).to receive(:allows).and_return(yes)
end
```

or

```
let(:no) { FatModelAuth::CannedGateKeeper.denies(:edit) }

it "does not allow"
  expect(article).to receive(:allows).and_returns(no)
end
```

## Model specs

### EDIT

`expect( article.allows( peon ).to_edit? ).to be false`

`expect( article.allows( admin ).to_edit? ).to be true`

### UPDATE

`expect( article.allows( peon ).to_update? ).to be false`

`expect( article.allows( admin ).to_update? ).to be true`


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/brentgreeff/fat_model_auth.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
