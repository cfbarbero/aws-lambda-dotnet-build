# aws-lambda-dotnet-build
Contains the tools to build &amp; package dotnet core aws lambdas


## Usage
1. Start a container with your project mapped as a volume
```
docker run -it --rm -v "$(PWD):/var/app" cfbarbero/aws-lambda-dotnet-build /bin/bash
```
1. Run dotnet commands against your project
   - Restore
   ```
   dotnet restore
   ```
    - Test
   ```
   dotnet test tests/tests.csproj
   ```  
   - Build
   ```
   cd src/project
   dotnet build
   ```
   - Lambda Package - *note:* this is different that the standard 'dotnet publish' command.  It automatically flattens the platform specific 'runtimes' folder in the generated build folder to target the aws lambda environment.  AWS Lambda runtime can't dynamically load platform assemblies from the runtime folder.
   ```
   cd src/project
   dotnet lambda package -f netcoreapp1.0 -c Release -o build.zip
   ```
   - Compile SAM template - *note:* this assumes that you have valid credentials in the container.
   ```
   aws cloudformation package --template-file serverless.template --s3-bucket <sam-artifactbucket> --output-template-file compiledTemplate.yaml
   ```

### AWS Credentials
To map credentials into the container you should map your ~/.aws folder into the container.

Running your container like below will set the aws credentials/config from your local machine available to any user of the docker container (ie root, jenkins, etc)
```
docker run -it --rm -e "HOME=/home" -v $HOME/.aws:/home/.aws cfbarbero/aws-lambda-dotnet-build 
```