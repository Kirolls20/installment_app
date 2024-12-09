BEGIN TRANSACTION
--
-- Create model Customer
--
CREATE TABLE [main_customer] ([id] bigint NOT NULL PRIMARY KEY IDENTITY (1, 1), [name] nvarchar(122) NOT NULL, [national_id] nvarchar(20) NOT NULL UNIQUE, [phone_number] nvarchar(20) NOT NULL, [email] nvarchar(254) NOT NULL, [address] nvarchar(max) NOT NULL, [created_at] datetimeoffset NOT NULL, [updated_at] datetimeoffset NOT NULL);
--
-- Create model Loan
--
CREATE TABLE [main_loan] ([id] bigint NOT NULL PRIMARY KEY IDENTITY (1, 1), [item] nvarchar(255) NULL, [amount] numeric(10, 2) NOT NULL, [interest_rate] numeric(5, 2) NOT NULL, [duration] int NOT NULL, [total_installments] numeric(10, 2) NOT NULL, [start_date] date NOT NULL, [end_date] date NOT NULL, [status] nvarchar(20) NOT NULL, [created_at] datetimeoffset NOT NULL, [customer_id_id] bigint NOT NULL);
--
-- Create model Installment
--
CREATE TABLE [main_installment] ([id] bigint NOT NULL PRIMARY KEY IDENTITY (1, 1), [installment_number] int NOT NULL, [installment_amount] numeric(10, 2) NOT NULL, [installment_date] date NOT NULL, [paid] bit NOT NULL, [payment_method] nvarchar(40) NOT NULL, [created_at] datetimeoffset NOT NULL, [updated_at] datetimeoffset NOT NULL, [loan_id_id] bigint NOT NULL);
CREATE INDEX [main_installment_loan_id_id_cbf8e4ed] ON [main_installment] ([loan_id_id]);
ALTER TABLE [main_installment] ADD CONSTRAINT [main_installment_loan_id_id_cbf8e4ed_fk_main_loan_id] FOREIGN KEY ([loan_id_id]) REFERENCES [main_loan] ([id]);
ALTER TABLE [main_loan] ADD CONSTRAINT [main_loan_customer_id_id_c56e4d25_fk_main_customer_id] FOREIGN KEY ([customer_id_id]) REFERENCES [main_customer] ([id]);
CREATE INDEX [main_loan_customer_id_id_c56e4d25] ON [main_loan] ([customer_id_id]);
COMMIT;
