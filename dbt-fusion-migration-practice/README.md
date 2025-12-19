# dbt Fusion Migration Practice Project

This is a sample dbt project **intentionally containing deprecations** for practicing the Fusion migration workflow using dbt-autofix.

## Purpose

This project is designed for the **"Migrating to Fusion"** learning module. It contains common deprecation patterns that learners will encounter and fix using dbt Studio's built-in migration workflow.

## Deprecations Included

This project contains the following intentional deprecations:

1. **MissingPlusPrefixDeprecation** - Configuration keys missing `+` prefix in `dbt_project.yml`
2. **source-paths deprecation** - Using old `source-paths` instead of `model-paths` in `dbt_project.yml`
3. **packages.yml deprecation** - Using `packages.yml` instead of `dependencies.yml`
4. **adapter_macro deprecation** - Old `adapter_macro()` pattern instead of `adapter.dispatch()` in macros
5. **Old test syntax** - Legacy test definitions in schema.yml and sources.yml
6. **Source freshness syntax** - Old freshness configuration patterns

These are all fixable by `dbt-autofix` and are representative of real-world migration scenarios.

## Setup Instructions

### Option 1: Use in dbt Cloud (Recommended for Learning Module)

1. **Fork or import this repository** to your GitHub/GitLab account
2. **Link it to a dbt Cloud project**:
   - Go to dbt Cloud
   - Create a new project or use existing
   - Connect to this repository
   - Configure connection to your data warehouse (Snowflake, BigQuery, etc.)
3. **Set up your development credentials**
4. **Open dbt Studio** and you're ready to start the migration module!

### Option 2: Use Locally

1. Clone this repository:
```bash
git clone <your-fork-url>
cd dbt-fusion-migration-practice
```

2. Install dbt and dbt-autofix:
```bash
pip install dbt-core dbt-snowflake  # or your adapter
pip install dbt-autofix
```

3. Configure your `profiles.yml` with warehouse credentials

4. Run deprecation check:
```bash
dbt-autofix deprecations
```

## Project Structure

```
dbt-fusion-migration-practice/
├── dbt_project.yml          # Contains MissingPlusPrefixDeprecation
├── models/
│   ├── staging/
│   │   ├── stg_customers.sql
│   │   ├── stg_orders.sql
│   │   └── stg_products.sql
│   ├── marts/
│   │   ├── dim_customers.sql
│   │   └── fct_orders.sql
│   └── schema.yml           # Contains old test syntax
├── seeds/
│   ├── raw_customers.csv
│   ├── raw_orders.csv
│   └── raw_products.csv
└── README.md
```

## What You'll Learn

By migrating this project, you'll practice:

- ✅ Identifying deprecations in job logs and Studio
- ✅ Using the "Check & fix deprecations" workflow in Studio
- ✅ Reviewing automated fixes in git diffs
- ✅ Enabling Fusion for your development environment
- ✅ Validating the migration was successful

## Expected Deprecations

When you run the deprecation check, you should see:

- **6+ MissingPlusPrefixDeprecations** in `dbt_project.yml`
- **source-paths deprecation** in `dbt_project.yml`
- **packages.yml deprecation** (file should be renamed to `dependencies.yml`)
- **adapter_macro deprecation** in `macros/deprecated_macros.sql`
- **Test syntax deprecations** in `schema.yml` and `sources.yml`
- **Source freshness deprecations** in `sources.yml`
- Total: **10-15 deprecations**

Most of these can be automatically fixed by dbt-autofix! Some (like packages.yml → dependencies.yml) may require manual file renaming.

## After Migration

Once you've successfully migrated and enabled Fusion, you can:

- Run `dbt compile` and see faster parse times
- Use LSP features in Studio (CTE preview, autocomplete, etc.)
- Continue to the "Fusion in Studio" module to explore LSP features

## Data Source

This project uses **seed files** (CSV data included in the repo) so you don't need external data sources. The seeds contain sample e-commerce data:

- `raw_customers.csv` - 50 sample customers
- `raw_orders.csv` - 200 sample orders
- `raw_products.csv` - 20 sample products

## Compatibility

- **dbt Version Required**: 1.7+ (or use user override in dbt Cloud)
- **Adapters Tested**: Snowflake, BigQuery, Postgres, Redshift
- **dbt Cloud**: Compatible with dbt Cloud Studio

## License

This project is for educational purposes as part of the dbt Fusion learning modules.

## Questions or Issues?

If you encounter issues with this practice project, please check:

1. Your dbt version is 1.7+
2. Your warehouse credentials are configured correctly
3. You've run `dbt deps` to install dependencies (if any)

Happy learning! 🚀

