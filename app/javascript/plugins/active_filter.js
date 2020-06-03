const activeFilter = () => {
  const footerElement = document.querySelectorAll('.footer-item');
  footerElement.forEach(element => {
    element.addEventListener('click', (event) => {
      const currentId = event.currentTarget.id;
      const currentActive = document.getElementById('active-item');
      const myTarget = document.getElementById(currentId);
      console.log(myTarget);
      myTarget.id = 'active-item';
      console.log(myTarget.id);
    });
  });
};

export { activeFilter };
