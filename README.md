# Readme
Triggering Actions run
Triggering Actions run
Triggering Actions run
Triggering Actions run
Triggering Actions run
Triggering Actions run
Triggering Actions run


You need Fluent Bit because CloudWatch itself cannot directly collect logs from inside your Kubernetes pods; CloudWatch is only a storage and visualization service — it doesn't automatically pull logs from EKS. Fluent Bit acts like a log shipper inside your cluster: it sits as a lightweight agent on the nodes, collects logs from your containers (from stdout and stderr), processes them if needed, and then sends (pushes) them securely into CloudWatch Logs. Without Fluent Bit (or a similar agent), your application logs would stay trapped inside the Kubernetes cluster and would never reach CloudWatch for centralized monitoring, alerting, or troubleshooting. ✅

Prometheus is different from Fluent Bit because Prometheus is used mainly for metrics collection, not for logs; it scrapes numerical data like CPU usage, memory consumption, and custom application metrics from your Kubernetes pods or nodes at regular intervals, but it does not collect logs like application outputs or error messages. In other words, Prometheus answers questions like “how many requests per second”, “how much memory is used”, while Fluent Bit answers “what exactly happened inside the app” through text-based logs. If you want full observability, you usually install both: Prometheus for metrics and Fluent Bit for logs, because they solve two different but equally important problems. ✅

Triggering Actions run
Triggering Actions run
