const filtersModal = () => {
  const filterButton = document.getElementById('filter-button');
  if (filterButton) {
    const caveFilters = document.getElementById('filters');
    filterButton.addEventListener("click", (event) => {
    event.preventDefault();
    caveFilters.classList.toggle("d-none");
    });
  }
};

export { filtersModal };
