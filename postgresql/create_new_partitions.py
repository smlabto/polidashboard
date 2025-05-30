from country_codes import codes
import sys

def create_partitions(country_code, table_name, sql_file, index_columns, vector_indexes=None):
    # Step 1: Create partition
    partition_name = f"{table_name}_{country_code.lower()}"
    
    sql_file.write(f"CREATE TABLE {partition_name} PARTITION OF {table_name} \n")
    sql_file.write(f"    FOR VALUES IN ('{country_code}');\n\n")

    # Step 2: Create indexes for the partition
    for column_list in index_columns:
        index_name = f"idx_{partition_name}_" + "_".join("".join(word[0] for word in col.split('_')) for col in column_list)
        index_columns_str = ", ".join(column_list)

        # Write CREATE INDEX statement
        sql_file.write(f"CREATE INDEX {index_name} ON {partition_name} ({index_columns_str});\n\n")

    # Step 3: Create the default partition
    default_partition_name = f"{table_name}_default"
    sql_file.write(f"CREATE TABLE {default_partition_name} PARTITION OF {table_name} DEFAULT;\n")


def generate_all_partitions(country_code, output_filename):
    with open(output_filename, "w") as sql_file:
        # Generate partitions for ad_data
        table_name = "ad_data"
        indexes = [["id"], ["bylines_name"], ["ad_delivery_start_time", "ad_delivery_stop_time"]]
        create_partitions(country_code, table_name, sql_file, indexes)

        # Generate partitions for ad_creative_content
        table_name = "ad_creative_content"
        indexes = [["content_order", "id"], ["ad_delivery_start_time", "ad_delivery_stop_time", "content_order", "id"], ["bylines_name", "ad_delivery_start_time", "ad_delivery_stop_time"]]
        create_partitions(country_code, table_name, sql_file, indexes)

        # Generate partitions for ad_region
        table_name = "ad_region"
        indexes = [["id"], ["id", "region"], ["bylines_name"], ["ad_delivery_start_time", "ad_delivery_stop_time", "region"], ["bylines_name", "ad_delivery_start_time", "ad_delivery_stop_time"]]
        create_partitions(country_code, table_name, sql_file, indexes)

        # Generate partitions for ad_demographic
        table_name = "ad_demographic"
        indexes = [["id"], ["id", "gender", "age_range"], ["bylines_name"], ["ad_delivery_start_time", "ad_delivery_stop_time", "gender", "age_range"], ["bylines_name", "ad_delivery_start_time", "ad_delivery_stop_time"]]
        create_partitions(country_code, table_name, sql_file, indexes)

    print(f"SQL file '{output_filename}' has been created successfully.")


if __name__ == "__main__":
    if len(sys.argv) > 1 <= 2:
        country_code = sys.argv[1]
        output_filename = "new_partions.sql"
        generate_all_partitions(country_code, output_filename)
    else:
        print("Usage: python create_partitions.py <country_code>")