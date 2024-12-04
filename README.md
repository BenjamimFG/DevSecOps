# Trabalho DevSecOps
Análise SAST, SCA, Secret Leaks da aplicação (VAmPI)[https://github.com/erev0s/VAmPI].

## Subir Jenkins e Defect Dojo locais

```sh
docker compose up -d --build
```

### Configurar Jenkins

1. Acessar a interface web do jenkins na máquina local em http://localhost:8081 e realizar o passo a passo
conforme exibido na interface para setup do usuário administrador.

2. Criar uma pipeline e nas configurações da pipeline setar o script de acordo com o arquivo `pipeline.JenkinsFile` no repositório.

3. Rodar o comando `docker compose logs initializer | grep "Admin password:"` para pegar o password admin do Defect Dojo

4. Logar na interface web to Defect Dojo em http://localhost:8080 com o usuário `admin` e a senha do passo anterior

5. Criar um novo projeto no Defect Dojo com o nome `VAmPI`

