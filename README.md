# engagement-analytics


## Goal
Build an end-to-end analytics project/dashboard that models how users engage with a mental-health or wellness product (e.g., therapy sessions, meditation content, messaging).

(Meta-goal:) Simulate the kind of reporting and insights a Data Analyst / Data Scientist would produce for product analytics

## Target users
* Product Managers (track KPIs, evaluate feature changes)
* Growth & Lifecycle teams (improve retention and activation)
* Clinical Operations / Care Navigation (monitor therapy follow-through)
* Executives (understand whether new features drive meaningful outcomes)

## Scope
* Create a user-level, event-level dataset mimicking an actual product’s clickstream.
* Define core engagement and retention metrics.
* Simulate and evaluate an A/B test for a feature intended to improve engagement.
* Build a dashboard showing funnels, retention, segments, and experiment results.
* Produce an executive insights report summarizing key findings and product recommendations.

## Dataset
* Utilize the BigQuery public dataset (Google Analytics, GA4 dataset) as base
* Convert the e-commerce evvents/dimensions to something more related to Mental health (session) event

## Tools & services 
The project uses the following tools and services: 
* BigQuery - for the source dataset
* dbt - For ETL/ELT transformations 
* FastAPI - Backend API for the dashboard 
* Streamlit - Frontend for the dashboard 
* Plotly - For data visualization 



## Gen AI used for: 
* Folder structure & file name suggestions 
* Makefile generation
* General Q&A about coding