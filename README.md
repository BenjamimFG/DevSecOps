# Trabalho DevSecOps
Análise SAST, SCA, Secret Leaks da aplicação [VAmPI](https://github.com/erev0s/VAmPI).

## Clonar repositório e submódulos

```sh
git clone --recurse-submodules https://github.com/BenjamimFG/DevSecOps.git
```

## Subir Jenkins e Defect Dojo locais

```sh
docker compose up -d --build
```

### Configurar DefectDojo

1. Rodar o comando `docker compose logs initializer | grep "Admin password:"` para pegar o password admin do Defect Dojo

2. Logar na interface web to Defect Dojo em http://localhost:8080 com o usuário `admin` e a senha do passo anterior

3. Criar um novo projeto no Defect Dojo com o nome `VAmPI`

4. Criar um `Engagement` no DefectDojo dentro do projeto `VAmPI` com o nome `Jenkins`

5. Acessar a chave de API do DefectDojo no endereço http://localhost:8080/api/key-v2


### Configurar Jenkins

1. Acessar a interface web do jenkins na máquina local em http://localhost:8081 e realizar o passo a passo conforme exibido na interface para setup do usuário administrador.

2. Criar uma pipeline e nas configurações da pipeline colar o script de acordo com o arquivo `pipeline.JenkinsFile` no repositório.

3. Criar uma credencial com o ID `DEFECT_DOJO_API_KEY` nas configurações do Jenkins local (http://localhost:8081/manage/credentials/store/system/domain/_/) do tipo `Secret text` o valor do campo `Secret` deve ser o valor da API KEY do defect dojo.



