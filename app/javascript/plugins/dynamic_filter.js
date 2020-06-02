const dynaFilter = () => {
  const region = document.getElementById('region-filter');
  if (region) {
    const firstRegionValue = Number.parseInt(region.value, 10);
    const myAppelations = document.getElementById('region-value');
    const appelations = JSON.parse(myAppelations.dataset.appelations);
    const appelationSelect = document.getElementById('appelation-filter');
    setAppelations(appelations, appelationSelect, region);
    region.addEventListener("change", (event) => {
      setAppelations(appelations, appelationSelect, region);
    });
  }
};

const setAppelations = (appelations, appelationSelect, region) => {
  const regionValue = Number.parseInt(region.value, 10);
  const filteredApp = appelations.filter(appelation => {
    return appelation.region_id == regionValue;
  });
  appelationSelect.innerHTML = `
  <option value="">Selectionner une appelation</option>\n
  ${buildOptions(filteredApp)};
  `
}

const buildOptions = (data) => {
  const parameters = window.location.search.split('&');
  let appId = 0;
  parameters.forEach(parameter => {
    if (parameter.charAt(0) === 'a') {
      appId = parseInt(parameter.split("=")[1]);
      console.log(appId);
    }
  });
  return data.map(appelation => {
    console.log(appelation.id);
    if (appelation.id === appId) {
      return `
      <option selected="selected" value="${appelation.id}">${appelation.name}</option>
      `
    } else {
    return `
    <option value="${appelation.id}">${appelation.name}</option>
    `
    }
  }).join('\n');
};

export { dynaFilter };
