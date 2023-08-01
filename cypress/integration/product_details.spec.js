/* eslint-disable no-undef */

describe("Jungle Product Details page from homepage", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("Users can navigate from the home page to the correct product detail page", () => {
    let productName;
    cy.get(".products article")
      .first("article")
      .then(($article) => {
        productName = $article.find("h1 span").text().split("$")[0];
        console.log(productName);
        cy.get(".products article")
          .first("article")
          .click()
          .then(() => {
            console.log(productName);
            cy.get(".product-detail").should("be.visible");
            cy.get(".product-detail").should("contain", productName);
          });
      });
  });
});
