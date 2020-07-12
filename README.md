# Microverse Ruby Capstone | Discord Bot

Microverse capstone project designed to evalue the student's ability to:
- Work under pressure
- Manage time properly
- Solve problems effectively
- Code solutions using Ruby best practices.

This project requirement was to build a bot for a platform, I choosed discord as the platform.

This discord bot is a dice roll bot intended to help D&D players to have a good time while having a call.

## Technologies used

- Ruby
- RSpec
- VS Code

**Installed gems**

- Dotenv
- Discordrb

## Requirements

- Ruby
- Dotenv
- Discordrb

### Installing the required gems

**On linux**

On a bash command line type:

>gem install dotenv <br>
>gem install discordrb

### Setting the environment variables and the bot

**Setting the bot**
First you will need a Discord account. If you don't have one, register [here](https://discord.com/new) <br>

Download the Discord app, and create a server. If you don't know how to create a discord server, take a look [here](https://www.howtogeek.com/364075/how-to-create-set-up-and-manage-your-discord-server/)

Then go to the [Discord application page](https://discord.com/developers/applications) while logged with your account.

![Discord page](./assets/2020-07-11_19-53.png)

Click the application button of the top right corner.

![App page](./assets/img2.png)

You will need the client ID. Now click on the bot tab on the left and create your bot. Pick a name and create your bot.

![Bot tkn](./assets/img3.png)

You will need the bot token for it to work

![Bot permissions](./assets/img4.png)

In the auth tab on the left, set the app type to bot, and set the permissions, the bot needs the permissions to send messages. After you set the permissions copy the link and open it, it will lead you to the add bot page, so you can add the bot to the server of your preference.

**Setting the environment variables**

Steps:

- Create a .env file in the project root folder
- Create a variable called "BOT_TOKEN" and store the bot token there.
- Create a variable called "CLIENT_ID" and store the client ID from the application page there.
- Create a variable called "BOT_PREFIX" and store a string there, that's the prefix needed to give the roll command to the bot.

![env variables](./assets/img5.png)

*Note: The prefix in the example is 'pls ', but it can be as simple as '!', the choice is yours.*

## Developer

- Github: [@alvp01](https://github.com/alvp01)
- Twitter: [@alvp01](https://twitter.com/alvp01)

### Extra material

- One [article](https://medium.com/@goodatsports/how-to-make-a-simple-discord-bot-in-ruby-to-annoy-your-friends-f5d0438daa70) on how to make a discord bot.
- Another [article](https://medium.com/@albert.palka/build-discord-bot-in-minutes-using-discordrb-gem-fa2da38668bb) about how to build a ruby bot and deploy it with heroku.