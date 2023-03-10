/// <reference types="cypress" />

describe('Add product to Cart', () => {
  beforeEach(() => {
    // Cypress starts out with a blank slate for each test
    // so we must tell it to visit our website with the `cy.visit()` command.
    // Since we want to visit the same URL at the start of all our tests,
    // we include it in our beforeEach function so that it runs before each test
    cy.visit('/')
  })

  it("Navigate to product page and adds 1 product to the cart", () => {
    cy.get('.products article a').first().click()
    cy.get('form .btn').contains('Add').click()
    cy.get('#navbarSupportedContent').contains('My Cart (1)').should('be.exist')

  });

})