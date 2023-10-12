# To learn makefiles: https://makefiletutorial.com/
# On windows, use NMake: https://docs.microsoft.com/pt-br/cpp/build/reference/nmake-reference?view=msvc-160
# Mais em: https://renatogroffe.medium.com/net-nuget-atualizando-packages-via-linha-de-comando-b0c6b596ed2
dotnetFramework = net7.0
solution = ./redirectr.sln
apiProject = ./redirectr.csproj
distPath = ./dist
NextReleaseNumber = 1.0
COMMIT_TO_TAG = HEAD
ReleaseOutputFile = PublishConfig = Release
PublishRuntime = linux-x64
PublishSelfConteined = 'true'

run-clean: clean restore build run

all : clean restore build

clean:
	dotnet clean ${solution}

restore:
	dotnet restore ${solution}

build:
	dotnet build -c Release ${solution}


update-dependencies:
	dotnet tool restore
	dotnet dotnet-outdated -u:Prompt ${solution}

check-vulnerabilities:
	dotnet tool restore
	dotnet list package --vulnerable
	dotnet security-scan ${solution} --excl-proj=tests/**

test:
	dotnet test ${solution}

# Executa apenas o método indicado, pelos parametros:
# PROJECT = Projeto (Ex: tests/Integrators/meuprojeto.tests/meuprojeto.tests.csproj)
# METHOD = Metodo (Ex: meuprojeto.tests.LinkParserTests.MustNotHaveMoreThan1000Characters)
# Ex: make watch-test-method PROJECT='tests/meuprojeto.controller.test/meuprojeto.controller.test.csproj' METHOD='meuprojeto.controller.test.service.LinkParser.MustNotHaveMoreThan1000Characters'
watch-test-method:
	dotnet watch test --project ${PROJECT} --filter "FullyQualifiedName=${METHOD}"

run:
	dotnet watch run --project ${apiProject}

publish:
	dotnet publish ${apiProject} --runtime ${PublishRuntime} -c Release -f ${dotnetFramework} --self-contained ${PublishSelfConteined} -o ${distPath}
