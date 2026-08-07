import { Button, Card, Text, Title } from '@mantine/core'

function App() {
  return (
    <div className="p-10">
      <Card shadow="sm" padding="lg">
        <Title order={2}>
          React + Tailwind + Mantine
        </Title>

        <Text mt="md">
          Setup works!
        </Text>

        <Button mt="md">
          Click me
        </Button>
      </Card>
    </div>
  )
}

export default App
