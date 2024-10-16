CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

CREATE TABLE employee_hierarchy (
    superior_id INT,
    subordinate_id INT,
    depth INT,
    PRIMARY KEY (superior_id, subordinate_id),
    FOREIGN KEY (superior_id) REFERENCES employees(employee_id),
    FOREIGN KEY (subordinate_id) REFERENCES employees(employee_id)
);

INSERT INTO employees (employee_id, name, manager_id) VALUES
(1, 'CEO', NULL),
(2, 'Manager1', 1),
(3, 'Manager2', 1),
(4, 'Employee1', 2),
(5, 'Employee2', 2),
(6, 'Employee3', 3),
(7, 'Employee4', 3),
(8, 'Intern1', 4),
(9, 'Intern2', 6);

INSERT INTO employee_hierarchy (superior_id, subordinate_id, depth)
SELECT DISTINCT e1.employee_id, e2.employee_id, 
    (SELECT COUNT(*) - 1 
     FROM employees e3 
     WHERE e3.employee_id BETWEEN e1.employee_id AND e2.employee_id 
     AND e3.manager_id IS NOT NULL) AS depth
FROM employees e1
JOIN employees e2 ON e1.employee_id < e2.employee_id
WHERE EXISTS (
    SELECT 1 FROM employees e3
    WHERE e3.employee_id = e2.employee_id
    AND e3.manager_id = e1.employee_id
);

-- Tampilkan jumlah total bawahan (bawahan langsung dan tidak langsung) seseorang.
SELECT 
    e.employee_id,
    e.name,
    COUNT(DISTINCT h.subordinate_id) AS total_subordinates
FROM 
    employees e
LEFT JOIN 
    employee_hierarchy h ON e.employee_id = h.superior_id
GROUP BY 
    e.employee_id, e.name
ORDER BY 
    e.employee_id;

-- Tampilkan jumlah total atasan (atasan langsung dan tidak langsung) seseorang.
SELECT 
    e.employee_id,
    e.name,
    COUNT(DISTINCT h.superior_id) AS total_superiors
FROM 
    employees e
LEFT JOIN 
    employee_hierarchy h ON e.employee_id = h.subordinate_id
GROUP BY 
    e.employee_id, e.name
ORDER BY 
    e.employee_id;