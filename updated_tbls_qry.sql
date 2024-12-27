BEGIN TRANSACTION
--
-- Create model Customer
--
CREATE TABLE [Customer] ([id] bigint NOT NULL PRIMARY KEY IDENTITY (1, 1), [name] nvarchar(122) NOT NULL, [national_id] nvarchar(20) NOT NULL UNIQUE, [phone_number] nvarchar(20) NOT NULL, [email] nvarchar(254) NOT NULL, [address] nvarchar(max) NOT NULL, [created_at] datetimeoffset NOT NULL, [updated_at] datetimeoffset NOT NULL);
--
-- Create model Loan
--
CREATE TABLE [Loan] ([id] bigint NOT NULL PRIMARY KEY IDENTITY (1, 1), [item] nvarchar(255) NULL, [amount] numeric(10, 2) NOT NULL, [interest_rate] numeric(5, 2) NOT NULL, [duration] int NOT NULL, [total_installments] numeric(10, 2) NOT NULL, [start_date] date NOT NULL, [end_date] date NOT NULL, [status] nvarchar(20) NOT NULL, [created_at] datetimeoffset NOT NULL, [customer_id_id] bigint NOT NULL);
--
-- Create model Installment
--
CREATE TABLE [Installment] ([id] bigint NOT NULL PRIMARY KEY IDENTITY (1, 1), [installment_number] int NOT NULL, [installment_amount] numeric(10, 2) NOT NULL, [installment_date] date NOT NULL, [paid] bit NOT NULL, [payment_method] nvarchar(40) NOT NULL, [created_at] datetimeoffset NOT NULL, [updated_at] datetimeoffset NOT NULL, [loan_id_id] bigint NOT NULL);
CREATE INDEX [Installment_loan_id_id_459a86f0] ON [Installment] ([loan_id_id]);
ALTER TABLE [Loan] ADD CONSTRAINT [Loan_customer_id_id_b018bfb8_fk_Customer_id] FOREIGN KEY ([customer_id_id]) REFERENCES [Customer] ([id]);
CREATE INDEX [Loan_customer_id_id_b018bfb8] ON [Loan] ([customer_id_id]);
ALTER TABLE [Installment] ADD CONSTRAINT [Installment_loan_id_id_459a86f0_fk_Loan_id] FOREIGN KEY ([loan_id_id]) REFERENCES [Loan] ([id]);
COMMIT;
