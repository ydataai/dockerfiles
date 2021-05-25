#! /bin/sh

elyra-metadata install runtimes \
--replace \
--name="ydata_pipelines" \
--display_name="YData Pipelines" \
--api_endpoint=http://ml-pipeline.kubeflow.svc.cluster.local:8888 \
--user_namespace="$NAMESPACE" \
--engine=Argo \
--cos_endpoint=http://minio-service.kubeflow:9000 \
--cos_username=minio \
--cos_password=minio123 \
--cos_bucket="elyra-$NAMESPACE" \
--schema_name=kfp

exec tini -g -- $@
