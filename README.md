# Provisionamento de Database

1. Pré-requisitos
    - Ter o Terraform instalado (versão ≥ 1.6).
    - Ter a CLI do GCP (gcloud) instalada e logada na conta correta.
    - Ter permissões para criar:
        - Buckets no GCS
        - Secret Manager
        - Service Accounts
        - Instâncias do Cloud SQL


2. Pré-requisitos 
Esses passos só precisam ser feitos uma vez por projeto/conta:

1. Criar bucket do Terraform state

    ```bash
    gsutil mb -l us-central1 gs://bucket-tfstate-grupo14-11soat
    ```

2. Criar service account de bootstrap
    ```bash
        gcloud iam service-accounts create teste-fiap-2 --display-name="teste-fiap-2"
    ```

3. Conceder permissões necessárias
Neste passo, iremos conceder as permissões necessárias para realizar o provisionamento.

    ```bash
    gcloud projects add-iam-policy-binding fiap-prj-fast-food-2 --member="serviceAccount:teste-fiap-2@fiap-prj-fast-food-2.iam.gserviceaccount.com" --role="roles/cloudsql.admin"

    gcloud projects add-iam-policy-binding fiap-prj-fast-food-2 --member="serviceAccount:teste-fiap-2@fiap-prj-fast-food-2.iam.gserviceaccount.com" --role="roles/secretmanager.admin"

    gcloud projects add-iam-policy-binding fiap-prj-fast-food-2 --member="serviceAccount:teste-fiap-2@fiap-prj-fast-food-2.iam.gserviceaccount.com" --role="roles/storage.admin"

    gcloud projects add-iam-policy-binding fiap-prj-fast-food-2 --member="serviceAccount:teste-fiap-2@fiap-prj-fast-food-2.iam.gserviceaccount.com" --role="roles/resourcemanager.projectIamAdmin"    

    gcloud projects add-iam-policy-binding fiap-prj-fast-food-2 --member="serviceAccount:teste-fiap-2@fiap-prj-fast-food-2.iam.gserviceaccount.com" --role="roles/storage.admin"

    gcloud projects add-iam-policy-binding fiap-prj-fast-food-2 --member="serviceAccount:teste-fiap-2@fiap-prj-fast-food-2.iam.gserviceaccount.com" --role="roles/compute.networkViewer"

    ```
4. É necessário habilitar as APIs para que o provisionamento funcione:
    - Cloud Resource Manager API 
    - Cloud SQL Admin API
    - Secret Manager API
    - Compute Engine API
4. Criar e baixar a chave JSON
    ```bash
        gcloud iam service-accounts keys create bootstrap-sa-1.json --iam-account=terraform-bootstrap@<PROJECT_ID>.iam.gserviceaccount.com
    ```
    Habilitar essa API - Vá em APIs & Services → Library → Cloud Resource Manager API → Enable.
    Habilitar essa API - Cloud SQL Admin API
    Habilitar essa API - Secret Manager API
    Console → APIs & Services → Library → Compute Engine API