const data = [
    { name: "John Doe", national_id: "1234567890", phone: "123-456-7890", email: "john@example.com", address: "123 Main St", created: "2023-01-01", updated: "2023-12-10" },
    { name: "Jane Smith", national_id: "9876543210", phone: "987-654-3210", email: "jane@example.com", address: "456 Elm St", created: "2023-02-15", updated: "2023-11-20" },
    // Add more sample data as needed
  ];
  
  // Pagination and variables
  let currentPage = 1;
  const rowsPerPage = 5;
  
  // Render Table
  function renderTable() {
    const tableBody = document.getElementById("tableBody");
    tableBody.innerHTML = "";
  
    const start = (currentPage - 1) * rowsPerPage;
    const end = start + rowsPerPage;
    const paginatedData = data.slice(start, end);
  
    paginatedData.forEach((item, index) => {
      const row = `<tr>
        <td>${start + index + 1}</td>
        <td>${item.name}</td>
        <td>${item.national_id}</td>
        <td>${item.phone}</td>
        <td>${item.email}</td>
        <td>${item.address}</td>
        <td>${item.created}</td>
        <td>${item.updated}</td>
      </tr>`;
      tableBody.innerHTML += row;
    });
  
    updatePagination();
  }
  
  // Sorting
  function sortTable(colIndex) {
    data.sort((a, b) => {
      const key = Object.keys(data[0])[colIndex - 1];
      return a[key].localeCompare(b[key]);
    });
    renderTable();
  }
  
  // Search
  document.getElementById("search").addEventListener("input", function (e) {
    const value = e.target.value.toLowerCase();
    const filteredData = data.filter((item) =>
      Object.values(item).some((val) => val.toLowerCase().includes(value))
    );
  
    currentPage = 1;
    updateTable(filteredData);
  });
  
  // Pagination
  function updatePagination() {
    const pageInfo = document.getElementById("pageInfo");
    pageInfo.textContent = `Page ${currentPage} of ${Math.ceil(data.length / rowsPerPage)}`;
  
    document.getElementById("prevBtn").disabled = currentPage === 1;
    document.getElementById("nextBtn").disabled = currentPage === Math.ceil(data.length / rowsPerPage);
  }
  
  document.getElementById("prevBtn").addEventListener("click", () => {
    if (currentPage > 1) {
      currentPage--;
      renderTable();
    }
  });
  
  document.getElementById("nextBtn").addEventListener("click", () => {
    if (currentPage < Math.ceil(data.length / rowsPerPage)) {
      currentPage++;
      renderTable();
    }
  });
  
  // Initialize
  renderTable();
  