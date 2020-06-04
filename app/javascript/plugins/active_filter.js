const activeFilter = () => {
  const footerElement = document.querySelectorAll('.footer-item');
  footerElement.forEach(element => {
    element.addEventListener('click', (event) => {
      // const currentId = event.currentTarget.id;
      const currentActive = document.querySelector('.active-item');
      // const myTarget = document.getElementById(currentId);
      console.log(event.currentTarget);
      if (currentActive) {
        currentActive.classList.remove('active-item');
      }
      // console.log();
      event.currentTarget.classList.add('active-item');
      console.log(event.currentTarget);

    });
  });
};

export { activeFilter };
