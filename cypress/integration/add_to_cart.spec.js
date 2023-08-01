/* eslint-disable no-undef */

describe("Jungle adding products to cart from homepage", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("Users can click the 'Add to Cart' button for a product on the home page and in doing so their cart increases by one", () => {
    //Record inital count of cart badge
    let initialCartCount;
    cy.get("a.nav-link[href='/cart']")
      .invoke("text")
      .then((text) => {
        initialCartCount = parseInt(text.split("(")[1].replace(")", ""));
        console.log(initialCartCount);
      });

    //find and click on add button for the first article
    cy.get(".products article")
      .first()
      .find(".btn")
      .contains("Add")
      .click({ force: true });

    //record updated cartcount
    cy.get("a.nav-link[href='/cart']")
      .invoke("text")
      .then((text) => {
        let updatedCartCount = parseInt(text.split("(")[1].replace(")", ""));
        console.log(updatedCartCount);
        //check for cart increase by 1
        expect(updatedCartCount).to.eq(initialCartCount + 1);
      });
  });
});
