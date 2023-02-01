/// <reference types="cypress" />

describe('Navigate to product page', () => {
  beforeEach(() => {
    // Cypress starts out with a blank slate for each test
    // so we must tell it to visit our website with the `cy.visit()` command.
    // Since we want to visit the same URL at the start of all our tests,
    // we include it in our beforeEach function so that it runs before each test
    cy.visit('/')
  })

  it("Navigate to product page when the image is clicked", () => {
    cy.get('.products article a img').first().click()
    cy.get('.quantity span').should('have.text', '18 in stock at $24.99')
  });
  
  it("Navigate to product page when the product name is clicked", () => {
    cy.get('.products article h1').contains('Scented Blade').click({ force: true })
    cy.get('.quantity span').should('have.text', '18 in stock at $24.99')
  });


})