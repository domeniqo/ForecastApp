# Create build and publish container
FROM mcr.microsoft.com/dotnet/sdk:6.0 as PUBLISHER

WORKDIR /ForecastApp

# Copy actual application state
COPY ./src/ForecastApp /ForecastApp

# Build and publish the application
RUN dotnet publish -o ./publish

# Import the ASP.NET Core into the container
FROM mcr.microsoft.com/dotnet/core/aspnet:2.1

# TCP Port where the container will be listening requests
EXPOSE 80
EXPOSE 443

# Working directory
WORKDIR /ForecastApp

# Copy the contents of the publish folder from PUBLISHER container inside the app folder
COPY --from=PUBLISHER ForecastApp/publish .

# Defines the entry point for our app
ENTRYPOINT ["dotnet", "ForecastApp.dll"]
