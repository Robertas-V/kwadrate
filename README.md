# KwadRate

This project is going to help drone pilots to assemble kwads with the better quality parts for best price.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

What things you need to install the software and how to install them

```
Give examples
```

### Installing

1. Install [yarn](https://yarnpkg.com/en/docs/install#windows-stable).

2. Open terminal window (cmd or powershell) and install angular cli:

```
yarn global add @angular/cli
```

3. Open new terminal window and setup yarn as a default package manager for angular:

```
ng config -g cli.packageManager yarn
```

if 3rd step doesn't work, you have to setup Environment variable for yarn:
Go to My Computer -> right click on This PC -> Properties -> Advanced System Settings -> Environmental Variables -> At User Variables select Path and click Edit -> New -> %LOCALAPPDATA%\Yarn\bin

Repeat 3rd step.

4. Check if everything is installed.

```
ng --version
```

5. Install all packages related to this project.

```
yarn install
```

6. Start server with auto reload and open application in browser.

```
ng serve -o
```

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Robertas V** - *Initial work* - [Profile](https://github.com/Robertas-V)
* **Evaldas B** - *Initial work* - [Profile](https://github.com/buinauskas)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc
