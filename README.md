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
        gcloud iam service-accounts create terraform-bootstrap --display-name="Terraform Bootstrap SA"
    ```

3. Conceder permissões necessárias
Neste passo, iremos conceder as permissões necessárias para realizar o provisionamento.

    ```bash
    gcloud projects add-iam-policy-binding <PROJECT_ID> --member="serviceAccount:terraform-bootstrap@<PROJECT_ID>.iam.gserviceaccount.com" --role="roles/cloudsql.admin"

    gcloud projects add-iam-policy-binding <PROJECT_ID> --member="serviceAccount:terraform-bootstrap@<PROJECT_ID>.iam.gserviceaccount.com" --role="roles/secretmanager.admin"

    gcloud projects add-iam-policy-binding <PROJECT_ID> --member="serviceAccount:terraform-bootstrap@<PROJECT_ID>.iam.gserviceaccount.com" --role="roles/storage.admin"
    ```
4. Criar e baixar a chave JSON
    ```bash
        gcloud iam service-accounts keys create bootstrap-sa.json --iam-account=terraform-bootstrap@<PROJECT_ID>.iam.gserviceaccount.com
    ```
