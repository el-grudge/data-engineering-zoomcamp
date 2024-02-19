# GCLOUD COMMANDS

gcloud projects add-iam-policy-binding linen-source-411501 \
    --member=user:msonboldezoomcamp@gmail.com \
    --role=roles/serviceusage.serviceUsageAdmin


(base) minasonbol@de-zoomcamp:~/.gc$ gcloud projects add-iam-policy-binding linen-source-411501 --member="user:msonboldezoomcamp@gmail.com" --role=roles/storage.objectViewer

gcloud auth list 

cloud projects create ocr-demo-0931

gcloud config set project ocr-demo-0931

gcloud services enable vision.googleapis.com

gcloud projects add-iam-policy-binding ocr-demo-0931 --member="user:minasonbol@gmail.com" --role=roles/storage.objectViewer

pip install --upgrade google-cloud-vision



gcloud auth list --filter=status:ACTIVE --format="value(account)"

gcloud iam roles list

gcloud projects get-iam-policy ocr-demo-0931


gcloud projects create linen-source-411501

gcloud config set project linen-source-411501

gcloud services enable vision.googleapis.com

gcloud projects add-iam-policy-binding linen-source-411501 --member="user:msonboldezoomcamp@gmail.com" --role=roles/storage.objectViewer

pip install --upgrade google-cloud-vision


# SCRAPY COMMAND

response.xpath('//head/script[contains(text(), "ImageObject") and contains(text(), "null")]').extract()[1]


scrapy shell "https://www.refinery29.com/en-us/philadelphia-medical-lab-scientist-money-diary"

# pages to scrape
https://www.refinery29.com/en-us/money-diary

https://www.refinery29.com/en-us/money-diary?json=true&page=10


1-25
from pages 1-25
