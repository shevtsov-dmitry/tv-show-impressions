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
import { useTvShowState } from '../state/tvShowState'
import { useEffect } from 'react'

const HTTP_SERVER_HOST = "localhost"
const HTTP_SERVER_PORT = 3000
const API_ROUTE = HTTP_SERVER_HOST + ":" + HTTP_SERVER_PORT + "/api"

const  lang_code = "en"


// const get_all_genres = async () => {
//   fetch(API_ROUTE + "/genre/all" + `?lang_code=${lang_code}` )
//     .then(resp => resp.json())
//     .then(raw_json => JSON.parse(raw_json) as string[])
//     .catch(err => console.error('ERROR: genre parse'))
//     .then(genres => useTvShowState(state => state))
// }

const AddTvShow = () => {

  // useEffect({
  //   get_all_genres()
  // }, [])


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
