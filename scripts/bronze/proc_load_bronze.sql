create or alter procedure bronze.load_bronze as 
begin 
	declare @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
	begin try
		set @batch_start_time = GETDATE();

				print '====================================================================================';
				print 'Load values in the table'; 
				print '====================================================================================';

		print '>>>>>Upload CRM CSV file to ssms>>>>>';

		set @start_time = GETDATE();
		truncate table bronze.crm_cust_info
		bulk insert bronze.crm_cust_info
		from 'D:\TEGMA BU SISTEMA\Desktop\Projects\source_crm\cust_info.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
			);
			set @end_time = GETDATE();
			print 'Load Duration:  ' + cast(datediff(second, @start_time, @end_time) as NVARCHAR) + ' seconds'; 

		set @start_time = GETDATE();
		truncate table bronze.crm_prd_info 
		bulk insert bronze.crm_prd_info
		from 'D:\TEGMA BU SISTEMA\Desktop\Projects\source_crm\prd_info.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
			);
			set @end_time = GETDATE();
			print 'Load Duration:  ' + cast(datediff(second, @start_time, @end_time) as NVARCHAR) + ' seconds'; 

		set @start_time = GETDATE();
		truncate table bronze.crm_sales_detials
		bulk insert bronze.crm_sales_detials
		from 'D:\TEGMA BU SISTEMA\Desktop\Projects\source_crm\sales_details.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
			);
			set @end_time = GETDATE();
			print 'Load Duration:  ' + cast(datediff(second, @start_time, @end_time) as NVARCHAR) + ' seconds'; 

										print '>>>>>Upload ERP CSV file to ssms<<<<<';
	
		set @start_time = GETDATE();
		truncate table bronze.erp_cust_az12
		bulk insert bronze.erp_cust_az12
		from 'D:\TEGMA BU SISTEMA\Desktop\Projects\source_erp\CUST_AZ12.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
			set @end_time = GETDATE();
			print 'Load Duration:  ' + cast(datediff(second, @start_time, @end_time) as NVARCHAR) + ' seconds'; 

			set @start_time = GETDATE();
			truncate table bronze.erp_loc_a101;
			bulk insert bronze.erp_loc_a101
		from 'D:\TEGMA BU SISTEMA\Desktop\Projects\source_erp\LOC_A101.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
			set @end_time = GETDATE();
			print 'Load Duration:  ' + cast(datediff(second, @start_time, @end_time) as NVARCHAR) + ' seconds'; 
			set @start_time = GETDATE();
			truncate table bronze.erp_px_cat_g1v2;
			bulk insert bronze.erp_px_cat_g1v2
		from 'D:\TEGMA BU SISTEMA\Desktop\Projects\source_erp\PX_CAT_G1V2.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE();
		print 'Load Duration:  ' + cast(datediff(second, @start_time, @end_time) as NVARCHAR) + ' seconds'; 
		print '>>>>>>....................';

		set @batch_end_time = GETDATE();
				print '====================================================================================';
				print 'Loading Bronze is Completed';
				print '- Total Load Duration ' + CAST(datediff(second, @batch_start_time, @batch_end_time) as NVARCHAR) + ' seconds';
				print '====================================================================================';

		end try
		begin catch
									print '=========================================='
									print 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
									print 'Error Message' + error_message();
									print 'Error Message' + cast(error_number() as NVARCHAR);
									print 'Error Message' + cast(error_state() as NVARCHAR);
									print '==========================================';
		end catch
end
