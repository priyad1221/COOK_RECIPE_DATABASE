CREATE DATABASE cook_recipe;
USE cook_recipe;

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL
);

CREATE TABLE Ingredients (
    IngredientID INT PRIMARY KEY,
    IngredientName VARCHAR(255) NOT NULL,
    MeasurementUnit VARCHAR(255) NOT NULL
);


CREATE TABLE Recipes (
    RecipeID INT PRIMARY KEY,
    RecipeName VARCHAR(255) NOT NULL,
    CategoryID INT,
    Instructions TEXT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE RecipeIngredients (
    RecipeID INT,
    IngredientID INT,
    Quantity DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (RecipeID, IngredientID),
    FOREIGN KEY (RecipeID) REFERENCES Recipes(RecipeID),
    FOREIGN KEY (IngredientID) REFERENCES Ingredients(IngredientID)
);


INSERT INTO Categories (CategoryID, CategoryName) VALUES
(1, 'Main Dishes'),
(2, 'Desserts'),
(3, 'Salads');

INSERT INTO Ingredients (IngredientID, IngredientName, MeasurementUnit) VALUES
(1, 'Chicken', 'lb'),
(2, 'Sugar', 'cup'),
(3, 'Lettuce', 'head');

INSERT INTO Recipes (RecipeID, RecipeName, CategoryID, Instructions) VALUES
(1, 'Grilled Chicken', 1, 'Grill the chicken until fully cooked.'),
(2, 'Chocolate Cake', 2, 'Bake the cake at 350°F for 30 minutes.'),
(3, 'Caesar Salad', 3, 'Mix lettuce, croutons, and dressing. Serve chilled.');

INSERT INTO RecipeIngredients (RecipeID, IngredientID, Quantity) VALUES
(1, 1, 2.5), -- 2.5 lbs of chicken for Grilled Chicken
(2, 2, 2),   -- 2 cups of sugar for Chocolate Cake
(3, 3, 1);   -- 1 head of lettuce for Caesar Salad


-- Get the total number of recipes
SELECT COUNT(*) FROM Recipes;

-- Get the average number of ingredients in a recipe
SELECT AVG(Quantity) FROM RecipeIngredients;

-- Get recipes with names containing "Chicken":
SELECT RecipeName
FROM Recipes
WHERE RecipeName LIKE '%Chicken%';

-- Get all recipes that start with the letter "C"
SELECT * FROM Recipes WHERE RecipeName LIKE 'C%';


-- Get the recipe with the most ingredients
SELECT RecipeID, MAX(Quantity) AS MostIngredients FROM RecipeIngredients GROUP BY RecipeID;


-- Get the names of recipes along with their categories:
SELECT r.RecipeName, c.CategoryName
FROM Recipes r
JOIN Categories c ON r.CategoryID = c.CategoryID;


-- Get the total number of recipes in each category:
SELECT c.CategoryName, COUNT(r.RecipeID) AS NumberOfRecipes
FROM Categories c
LEFT JOIN Recipes r ON c.CategoryID = r.CategoryID
GROUP BY c.CategoryName;

-- Get recipes from a specific category (e.g., Main Dishes):
SELECT RecipeName
FROM Recipes
WHERE CategoryID = 1;


-- Get all the recipes in a specific category
SELECT Recipes.RecipeName, Categories.CategoryName
FROM Recipes
JOIN Categories ON Recipes.CategoryID = Categories.CategoryID
WHERE Categories.CategoryID = 2;


