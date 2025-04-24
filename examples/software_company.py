"""
Software Company Example for MetaGPT

This example demonstrates how to use MetaGPT's software company feature
to automatically generate a software project from a simple requirement.
"""

import os
import asyncio
from metagpt.software_company import SoftwareCompany
from metagpt.roles import (
    ProductManager,
    Architect,
    ProjectManager,
    Engineer,
)


async def main():
    """Run the software company example"""
    
    # Create the company with different roles
    company = SoftwareCompany()
    
    # Hire roles
    company.hire([
        ProductManager(),
        Architect(),
        ProjectManager(),
        Engineer(),
    ])
    
    # Set the project directory
    workspace_path = os.path.join(os.getcwd(), "workspace")
    os.makedirs(workspace_path, exist_ok=True)
    
    # Define a simple requirement
    requirement = "Create a simple TODO list web application"
    
    # Start the project
    print(f"Starting project with requirement: {requirement}")
    print("This will take some time depending on your LLM API speed...")
    
    result = await company.run(requirement, output_path=workspace_path)
    
    # Print the result and location of the generated code
    print(f"Project generated in: {workspace_path}")
    print(f"Result: {result}")


if __name__ == "__main__":
    # Run the async main function
    asyncio.run(main())