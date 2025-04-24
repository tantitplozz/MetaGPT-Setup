"""
Hello World Example for MetaGPT

This is a simple example to verify your MetaGPT installation is working correctly.
"""

import asyncio
from metagpt.roles import Role
from metagpt.team import Team


class HelloWorld(Role):
    """A simple role that says hello"""
    
    async def run(self, message):
        """Run when receiving a message"""
        return f"Hello from MetaGPT! I received: '{message}'"


async def main():
    # Create a role
    hello_role = HelloWorld()
    
    # Create a team with just one role
    team = Team()
    team.hire([hello_role])
    
    # Send a message to the team
    result = await team.run("World")
    print(result)


if __name__ == "__main__":
    # Run the async main function
    asyncio.run(main())