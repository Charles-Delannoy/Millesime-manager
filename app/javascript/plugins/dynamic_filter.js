const dynaFilter = () => {
  const region = document.getElementById('region-filter');
  if (region) {
    region.addEventListener("change", (event) => {
      const regionValue = region.value
      console.log(regionValue)
    });
  }
};

export { dynaFilter };
