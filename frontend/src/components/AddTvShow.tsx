import {
  Box,
  Button,
  Checkbox,
  Container,
  Flex,
  Grid,
  Input,
  MultiSelect,
  Select,
  Text,
  Textarea,
  Title,
} from '@mantine/core'
import { useEffect, useState } from 'react'


const AddTvShow = () => {

  const LANGUAGE_CODE = "ru"
  const API_URL = import.meta.env.VITE_API_URL

  interface Genre {
    id: number,
    name: string,
    language_code: string,
  }

  const [genres, setGenres] = useState<Genre[]>([])
  const [selectedGenresIds
    , setSelectedGenresIds] = useState<number[]>([])

  useEffect(() => {
    const fetchGenres = async () =>
      fetch(API_URL + "/genre/all")
        .then(resp => resp.json() as Promise<Genre[]>)
        .then(arrayGenres => setGenres(arrayGenres.filter(genre => genre.language_code == LANGUAGE_CODE)))

    fetchGenres()
  }, [])

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
          <MultiSelect
            label="select genres"
            data={genres.map((v, _idx) =>
              ({ value: `${v.id}`, label: v.name })
            )}
            value={selectedGenresIds.map(String)}
            onChange={values => { setSelectedGenresIds(values.map(Number)) }}
          />
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
