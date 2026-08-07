import {
  Box,
  Button,
  Checkbox,
  Container,
  Flex,
  Grid,
  Input,
  Select,
  Text,
  Textarea,
  Title,
} from '@mantine/core'

const AddTvShow = () => {
  return (
    <Container>
      <Title>NEW CONTENT</Title>
      <Box>
        <Text fw={'bold'}>general info</Text>
        <Flex gap="1%">
          <Input placeholder="title" />
          <Button>+en</Button>
        </Flex>
      </Box>
      <Grid>
        <Box>
          <Text>format</Text>
          <Input />
        </Box>
        <Box>
          <Text>year</Text>
          <Input />
        </Box>
        <Box>
          <Text>finished</Text>
          <Checkbox />
        </Box>
        <Box>
          <Text>genres</Text>
          <Input />
        </Box>
        <Box>
          <Text>setting</Text>
          <Button>+</Button>
        </Box>
        <Box>
          <Text>country</Text>
          <Input />
        </Box>
      </Grid>
      <hr />
      <Text fw={'bold'}>Impressions</Text>
      <Box>
        <Text>Expectations</Text>
        <Input />
      </Box>
      <Box>
        <Text>Impressions</Text>
        <Input />
      </Box>
      <Box>
        <Text>Mood</Text>
        <Input />
      </Box>
      <Flex gap="1%">
        <Text>Strengths</Text>
        <Input />
        <Button>+</Button>
      </Flex>
      <Flex gap="1%">
        <Text>Annoyances</Text>
        <Input />
        <Button>+</Button>
      </Flex>
      <hr />
      <Text fw={'bold'}>Pacing</Text>
      <Grid>
        <Box>
          <Text>visuals</Text>
          <Select />
        </Box>
        <Box>
          <Text>dialogs</Text>
          <Select />
        </Box>
        <Box>
          <Text>characters</Text>
          <Select />
        </Box>
        <Box>
          <Text>story</Text>
          <Select />
        </Box>
        <Box>
          <Text>atmosphere</Text>
          <Select />
        </Box>
        <Box>
          <Text>originality</Text>
          <Select />
        </Box>
      </Grid>
      <hr />
      <Text fw={'bold'}>more details</Text>
      <Textarea />
    </Container>
  )
}

export default AddTvShow
