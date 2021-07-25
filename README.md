# Azure DevOps Pipelines with GitHub as VCS

## Agenda

1. Create a Springboot Application with Maven and Java
2. Host the Springboot Application on GitHub
3. Deploy your packaged file to Azure Feeds
4. Create a Maven Release for your project
5. Setup Build Pipeline for Maven Release
6. Setup Release Pipeline in Azure DevOps for deployment to K8s

### 1. Create a Springboot Application with Maven and Java

https://github.com/nishkarshRaj/maven-using-cmd

### 2. Host the Springboot Application on GitHub

```
git init
git remote add origin ""
git config --local user.name ""
git config --local user.email ""

git add ""
git commit -m ""
git push -u origin [branch name]
```

### 3. Deploy your packaged file to Azure Feeds

```xml
	<repositories>
	 <repository>
		<id>NishkarshRaj</id>
		<url>https://pkgs.dev.azure.com/NishkarshRaj/_packaging/NishkarshRaj/maven/v1</url>
		<releases>
		  <enabled>true</enabled>
		</releases>
		<snapshots>
		  <enabled>true</enabled>
		</snapshots>
	  </repository>
	</repositories>

	<distributionManagement>
	  <repository>
		<id>NishkarshRaj</id>
		<url>https://pkgs.dev.azure.com/NishkarshRaj/_packaging/NishkarshRaj/maven/v1</url>
		<releases>
		  <enabled>true</enabled>
		</releases>
		<snapshots>
		  <enabled>true</enabled>
		</snapshots>
	  </repository>
	</distributionManagement>
```

```
mvn clean install
mvn deploy
```

### 4. Create a Maven Release for your project

```xml
	<scm>
        <developerConnection>scm:git:https://github.com/NishkarshRaj/az-dev-community-demo</developerConnection>
      <tag>nish-1.0.0</tag>
   </scm>

	<build>
		<plugins>
			<plugin>
				<groupId>org.apache.maven.plugins</groupId>
				<artifactId>maven-release-plugin</artifactId>
				<version>3.0.0-M4</version>
					<configuration>
						<username>NishkarshRaj</username>
						<password>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</password>
					</configuration>
				  </plugin>
				
			<plugin>
			 <groupId>org.springframework.boot</groupId>
			 <artifactId>spring-boot-maven-plugin</artifactId>
			</plugin>
		</plugins>
	</build>
```

```
git checkout master
git config --local user.name ""
git config --local user.email ""
mvn release:prepare --batch-mode
mvn release:perform
```

### 5. Setup Build Pipeline for Maven Release

### 6. Setup Release Pipeline in Azure DevOps for deployment to K8s

```
docker build -t [] -f [] .
docker tag [] []

az login --use-device-code
az acr login -n azdev

docker push []

kubectl apply -f k8s.yaml
```

```
ACR_NAME=[]
ACR_REGISTRY_ID=$(az acr show --name $ACR_NAME --query id --output tsv)
az ad sp create-for-rbac --scopes $ACR_REGISTRY_ID --role acrpull

kubectl create secret docker-registry cred \
--namespace default \
--docker-server=azdev.azurecr.io \
--docker-username=$SP_APP_ID \
--docker-password=$SP_PASSWD
```

