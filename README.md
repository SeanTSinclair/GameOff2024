
![splash](https://github.com/user-attachments/assets/58d1ee2c-69ce-4a08-8722-0255f3951e03)

# Introduction
Let's make a game at GitHub's 2024 GameOff Game Jam!

# Getting started

## Discord
[Join the Stavanger GameDev community](https://discord.gg/zPCWAevqen)

## Tools

### [Godot](https://godotengine.org/download/archive/4.3-stable/)
> We make the game here.

#### Plugins for Godot: 
- [Dialogic](https://github.com/dialogic-godot/dialogic)
- [SoundManager](https://gitlab.com/Xecestel/sound-manager)

### [Blender](https://www.blender.org/)
> We make the 3D models here

### [Logic Pro](https://www.apple.com/logic-pro/)
> We make the music and SFX here


## Contributing

### Local development
#### [GdScript Toolkit](https://github.com/Scony/godot-gdscript-toolkit)
> This does linting and other things, but we use mostly just linting
> This is automated in the pre-commit script

If you want to run the linter before commiting manually you may do so using the command `gdlint

#### [Pre-commit](https://pre-commit.com/)
> This does stuff before you commit so that we maintain a clean git history.

##### How to install:
1. Make sure you have python and pip installed.
2. run  `pip install -r requirements.txt`
    -  If you for some reason have issues running this command a solution could be to run `python3 -m pip install -r requirements.txt`
    - This installs pre-commit and gdscript toolkit
3. Run `pre-commit install` in the root of the project.

Now every time you run `git commit` the GdScript Toolkit linter is executed, and you must resolve any linting issues before a commit is accepted. 

##### For the more terminal savvy devs
- If you primarily use git through the terminal you should set up a venv for the python environment.

```bash
py -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

Also - I can highly recommend lazygit if you prefer the terminal.


# Credits

## Contributors

- Aina - Writer/Storyboard/Developer
- Espen Susort - 3D artist/Level designer
- Irina - Game designer
- Kristian Hiim - Developer
- Marius Bakkeli - Developer
- Marius Horne - Developer
- Martin Aarsland - Music/SFX
- Sean Sinclair - Project manager/Developer
- Uni Susort - Game director/3D artist
- Vidar Hiim - QA

Huge thanks to everyone that contributed, it was an amazing journey! ❤️
