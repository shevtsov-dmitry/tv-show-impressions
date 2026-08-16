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
import { useTvShowState } from '../state/tvShowState'
import type { Impressions } from '../types'

const AddTvShow = () => {

  const API_URL = import.meta.env.VITE_API_URL

  const [selectedGenresIds
    , setSelectedGenresIds] = useState<number[]>([])

  const [genresFetched, setGenresFetched] = useState<string[]>()
  const [formatFetched, setFormatFetched] = useState<string[]>()
  const [expectationsFetched, setExpectationsFetched] = useState<string[]>()
  const [impressionsFetched, setImpressionsFetched] = useState<Impressions[]>()
  const [moodFetched, setMoodFetched] = useState<string[]>()
  const [strengthsFetched, setStrengthsFetched] = useState<string[]>([])
  const [annoyancesFetched, setAnnoyancesFetched] = useState<string[]>([])
  const [settingFetched, setSettingFetched] = useState<string[]>([])

  const fetchAllGenres = async () =>
    fetch(API_URL + "/genre/all")
      .then(resp => resp.json() as Promise<string[]>)
      .then(items => setGenresFetched(items))

  const fetchAllFormats = async () =>
    fetch(API_URL + "/format/all")
      .then(resp => resp.json() as Promise<string[]>)
      .then(items => setFormatFetched(items))

  const fetchExpectationFormats = async () =>
    fetch(API_URL + "/expectation/all")
      .then(resp => resp.json() as Promise<string[]>)
      .then(items => setExpectationsFetched(items))

  const fetchImpressionFormats = async () =>
    fetch(API_URL + "/impression/all")
      .then(resp => resp.json() as Promise<Impressions[]>)
      .then(items => setImpressionsFetched(items))

  const fetchMoodFormats = async () =>
    fetch(API_URL + "/mood/all")
      .then(resp => resp.json() as Promise<string[]>)
      .then(items => setMoodFetched(items))

  const fetchStrengthFormats = async () =>
    fetch(API_URL + "/strength/all")
      .then(resp => resp.json() as Promise<string[]>)
      .then(items => setStrengthsFetched(items))

  const fetchAnnoyanceFormats = async () =>
    fetch(API_URL + "/annoyance/all")
      .then(resp => resp.json() as Promise<string[]>)
      .then(items => setAnnoyancesFetched(items))

  const fetchSettingFormats = async () =>
    fetch(API_URL + "/setting/all")
      .then(resp => resp.json() as Promise<string[]>)
      .then(items => setSettingFetched(items))

  useEffect(() => {
    // TODO fetch when user hovered item
    fetchAllGenres()
    fetchAllFormats()
    fetchExpectationFormats()
    fetchAllFormats()
    fetchImpressionFormats()
    fetchMoodFormats()
    fetchStrengthFormats()
    fetchAnnoyanceFormats()
    fetchSettingFormats()
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
          <Select
            label="Tv-show format"
            data={formatFetched}
            onChange={value => useTvShowState(state => state.set_format(value))}
          />
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
          <MultiSelect
            label="genres"
            placeholder=''
            data={useTvShowState(state => state.genre)}
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
