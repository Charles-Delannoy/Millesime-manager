const dynaFilter = () => {
  const region = document.getElementById('region-filter');
  if (region) {
    const myAppelations = document.getElementById('region-value');
    const appelations = JSON.parse(myAppelations.dataset.appelations);
    const appelationSelect = document.getElementById('appelation-filter');
    region.addEventListener("change", (event) => {
      const regionValue = Number.parseInt(region.value, 10);
      const filteredApp = appelations.filter(appelation => {
        return appelation.region_id == regionValue;
      });
      console.log(filteredApp);
      appelationSelect.innerHTML = `
      <option value="">Selectionner une appelation</option>\n
      ${buildOptions(filteredApp)};
      `
    });
  }
};

const buildOptions = (data) => {
  return data.map(appelation => {
    return `
    <option value="${appelation.id}">${appelation.name}</option>
    `
  }).join('\n');
};

export { dynaFilter };
