from fastapi import APIRouter
from google.cloud import bigquery
import os

router = APIRouter()

# Client will be initialized lazily or we can initialize here if creds are present
# relying on ADC
try:
    client = bigquery.Client()
except Exception as e:
    print(f"Warning: BigQuery client could not be initialized. {e}")
    client = None

@router.get("/engagement_metrics")
def get_engagement_metrics():
    if not client:
        return {"error": "BigQuery client not initialized"}
    
    # Querying dbt model
    query = """
    SELECT 
        event_name as metric,
        COUNT(*) as value
    FROM `dashboard-project-425723.engagement_analytics_dev.stg_ga4`
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 10
    """
    try:
        query_job = client.query(query)
        results = [dict(row) for row in query_job]
        return {"data": results}
    except Exception as e:
        return {"error": str(e)}
