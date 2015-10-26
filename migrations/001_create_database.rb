Sequel.migration do
  up do
    create_table(:scans) do
      primary_key :id

      String :filename, null: false
      DateTime :created_at, null: false
    end
  end

  down do
    drop_table(:scans)
  end
end
