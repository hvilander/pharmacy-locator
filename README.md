# Pharmacy Locator
An example API for a coding challenge and unstyled minimal React frontend. API is implemented in Ruby on Rails and is also set to serve the frontend.

## API
Provides information on the nearest pharmacy given a reference latitude and longitude.

### Endpoint
`GET {root}/pharmacy?latitude=<reference latitude>&longitude=<reference longitude>`

### Example
`http://localhost:3000/pharmacy?latitude=39.05&longitude=-94.611`

### Sample Response
```js
{
  "pharmacy": {
    "name":"PRICE CHOPPER PHARMACY",
    "address":"3700 W 95TH ST",
    "city":"LEAWOOD",
    "state":"KS",
    "zip":66206,
    "latitude":38.95792,
    "longitude":-94.628815,
    "distance":6.440824240440002
  }
}
```

### Query Parameters
| Parameter | Required | Description |
|---|---|---|
| latitude  | yes | The latitude to use as the reference point, must be between -90 and 90 inclusive.  |
| longitude  | yes  |  The longitude to use as the reference point, must be between -180 and 180 inclusive. |

## Setup
Instructions for Mac, tested on macOS 10.15.6 Catalina

System dependencies: 
|Dependency| Version| Useful links|
|---|---|---|
|Ruby:| `2.6.3`| Version manager: [rvm](https://rvm.io) |
|Rails: | `6.0.3.4`| [Rails](https://guides.rubyonrails.org)| 
|PostgreSQL: | `13.0`| See [PostgreSQL Setup](###-postgresql-setup) |
|Node: | `10.15.3`| Version manager: [nvm](https://github.com/nvm-sh/nvm#node-version-manager---)|
|Bundler: | `2.1.4` | [bundler.io](https://bundler.io)|
|yarn: | 1.22.5 | required for rails to pack frontend [yarn](https://classic.yarnpkg.com/en/docs/install/#mac-stable)|

### PostgreSQL Setup 

Assuming you have homebrew installed, you can use it to install postgres. This will give you the latest version. 

`brew install postgresql` 

You will need to add PostgreSQL to your path. Add something like this to your relvant shell profile. Note my version was 13, if you are on another version you would need to replace the `13`.

`export PATH="/usr/local/opt/postgresql@13/bin:$PATH"`

This will start the service and enable it to start at logon.

`brew services start postgres`

You may have to restart your shell to see the change to your shell config. Or simply rerun your shell's profile or rc file. Zsh is used in this example.

`source ~/.zshrc`

Running this will confirm PostgreSQL is installed correctly. If you see the version, it is installed correctly.

`postgres -V`

Finally you will need to create a db user. The `-P` flag will prompt for password creation. The `-d` flag will give the user permission to create databases. Take note of the name, rails db configuration is set to use this exact user name. 

`createuser -P -d pharmacy-finder` 

To simplify configuration, instead of modifying config files, Rails will get the crendentials from an environment variable. Add it to your shell config. Again the example uses zsh, you may need to adjsut for your shell. Refresh your shell again as above. Replace `YOUR PASSWORD HERE` with the db password set in the previous step.

`echo 'export rx_db_pw="YOUR PASSWORD HERE"' >> ~/.zshrc`

### Project setup
1. Clone the repo

    `git clone https://github.com/hvilander/pharmacy-locator.git`

2. Install Gems
Assumes you have [bundler](https://guides.rubyonrails.org/v6.0/getting_started.html), from the project directory run:

    `bundle install`

3. Seed the DB
Run once, to popluate the database with seed data from `lib/seeds/pharmacies.csv`

    `rake db:setup`

    `rake db:migrate`

4. Install Node modules
Installs the modules to run the front end. Note rails is also using yarn to run webpack.

    `yarn install`

5. Start the server

    `bundle exec rails s`

## Example site
Once the rails server is running you can view the unstyled example front end by visiting 

http://localhost:3000

Clicking the `Find Nearest Pharmacy` button will use the latitude and longitude in the text boxes to calcuate and find the nearest pharmacy in the database. There is not currently a view to show an error. Leaving either of the coordinates blank or not a number within the bounds of real latitude/longitude values will log an error to the console. 

Distance is calulated using [geokit-rails](https://github.com/geokit/geokit-rails). Instead of re-implementing a haversine or other methods I elected to go with the geokit library as it also opens up geocoding options like inputing an address 

## Testing
Currently tests only exist for the API. You can run them with

`bundle exec rspec`
