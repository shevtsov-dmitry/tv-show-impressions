import {
  ActionIcon,
  Badge,
  Box,
  Button,
  Checkbox,
  Container,
  Divider,
  Flex,
  Grid,
  Group,
  Input,
  Paper,
  Select,
  Stack,
  Text,
  Textarea,
  Title,
} from '@mantine/core'
import {
  IconCheck,
  IconDeviceTv,
  IconPlus,
  IconSparkles,
  IconX,
} from '@tabler/icons-react'

const AddTvShow = () => {
  return (
    <Box
      mih="100vh"
      bg="var(--mantine-color-dark-8)"
      py="xl"
      style={{
        overflow: 'hidden',
      }}
    >
      <Container size="xl" h="100%">
        {/* Header */}
        <Flex justify="space-between" align="flex-end" mb="lg">
          <Box>
            <Group gap="xs" mb={4}>
              <IconDeviceTv size={18} />
              <Text size="xs" fw={700} tt="uppercase" c="dimmed" lts={1.5}>
                Library
              </Text>
            </Group>

            <Title order={1} fw={800} lts={-1}>
              New show impression
            </Title>

            <Text size="sm" c="dimmed" mt={4}>
              Add a show, movie or other piece of content to your library.
            </Text>
          </Box>

          <Group>
            <Button variant="subtle" color="gray">
              Cancel
            </Button>

            <Button leftSection={<IconCheck size={17} />}>
              Save content
            </Button>
          </Group>
        </Flex>

        {/* Main form */}
        <Grid gutter="md">
          {/* LEFT COLUMN */}
          <Grid.Col span={7}>
            <Stack gap="md">
              {/* General */}
              <Paper
                p="lg"
                radius="md"
                withBorder
                bg="var(--mantine-color-dark-7)"
              >
                <SectionHeader
                  icon={<IconDeviceTv size={18} />}
                  title="General info"
                  description="Basic information about the content"
                />

                <Stack gap="md">
                  <Flex gap="sm" align="flex-end">
                    <Input.Wrapper
                      label="Title"
                      description="Original or preferred title"
                      style={{ flex: 1 }}
                    >
                      <Input
                        size="md"
                        placeholder="e.g. Severance"
                      />
                    </Input.Wrapper>

                    <ActionIcon
                      size={42}
                      variant="light"
                      aria-label="Add translation"
                    >
                      <IconPlus size={18} />
                    </ActionIcon>
                  </Flex>

                  <Grid gutter="sm">
                    <Grid.Col span={4}>
                      <Input.Wrapper label="Format">
                        <Select
                          placeholder="Select"
                          data={['TV Series', 'Mini Series', 'Movie', 'Anime']}
                        />
                      </Input.Wrapper>
                    </Grid.Col>

                    <Grid.Col span={4}>
                      <Input.Wrapper label="Year">
                        <Input placeholder="2026" />
                      </Input.Wrapper>
                    </Grid.Col>

                    <Grid.Col span={4}>
                      <Input.Wrapper label="Country">
                        <Input placeholder="USA" />
                      </Input.Wrapper>
                    </Grid.Col>

                    <Grid.Col span={6}>
                      <Input.Wrapper label="Genres">
                        <Input placeholder="Drama, Sci-Fi..." />
                      </Input.Wrapper>
                    </Grid.Col>

                    <Grid.Col span={6}>
                      <Input.Wrapper label="Setting">
                        <Flex gap="xs">
                          <Input
                            placeholder="Add setting"
                            style={{ flex: 1 }}
                          />
                          <ActionIcon
                            size={36}
                            variant="light"
                            aria-label="Add setting"
                          >
                            <IconPlus size={17} />
                          </ActionIcon>
                        </Flex>
                      </Input.Wrapper>
                    </Grid.Col>
                  </Grid>

                  <Paper
                    p="sm"
                    radius="sm"
                    bg="var(--mantine-color-dark-6)"
                    withBorder
                  >
                    <Checkbox
                      label="Finished"
                      description="Mark this content as completed"
                    />
                  </Paper>
                </Stack>
              </Paper>

              {/* Impressions */}
              <Paper
                p="lg"
                radius="md"
                withBorder
                bg="var(--mantine-color-dark-7)"
              >
                <SectionHeader
                  icon={<IconSparkles size={18} />}
                  title="Impressions"
                  description="Your personal reaction to the content"
                />

                <Stack gap="sm">
                  <Input.Wrapper label="Expectations">
                    <Input placeholder="What did you expect before watching?" />
                  </Input.Wrapper>

                  <Input.Wrapper label="Impressions">
                    <Input placeholder="What stayed with you?" />
                  </Input.Wrapper>

                  <Input.Wrapper label="Mood">
                    <Input placeholder="How did it make you feel?" />
                  </Input.Wrapper>

                  <Grid gutter="sm">
                    <Grid.Col span={6}>
                      <TagInput label="Strengths" placeholder="What worked?" />
                    </Grid.Col>

                    <Grid.Col span={6}>
                      <TagInput label="Annoyances" placeholder="What bothered you?" />
                    </Grid.Col>
                  </Grid>
                </Stack>
              </Paper>
            </Stack>
          </Grid.Col>

          {/* RIGHT COLUMN */}
          <Grid.Col span={5}>
            <Stack gap="md">
              {/* Pacing */}
              <Paper
                p="lg"
                radius="md"
                withBorder
                bg="var(--mantine-color-dark-7)"
              >
                <SectionHeader
                  title="Pacing"
                  description="Rate individual aspects of the experience"
                />

                <Grid gutter="sm">
                  {[
                    'Visuals',
                    'Dialogs',
                    'Characters',
                    'Story',
                    'Atmosphere',
                    'Originality',
                  ].map((item) => (
                    <Grid.Col span={6} key={item}>
                      <Select
                        label={item}
                        placeholder="Select"
                        data={[
                          'Excellent',
                          'Good',
                          'Average',
                          'Weak',
                          'Poor',
                        ]}
                      />
                    </Grid.Col>
                  ))}
                </Grid>
              </Paper>

              {/* More details */}
              <Paper
                p="lg"
                radius="md"
                withBorder
                bg="var(--mantine-color-dark-7)"
                style={{ flex: 1 }}
              >
                <SectionHeader
                  title="More details"
                  description="Anything else worth remembering"
                />

                <Textarea
                  placeholder="Write your notes..."
                  minRows={7}
                  autosize
                  maxRows={9}
                />

                <Group gap="xs" mt="md">
                  <Badge variant="light">personal</Badge>
                  <Badge variant="light">review</Badge>
                  <Badge variant="light">notes</Badge>
                </Group>
              </Paper>

              {/* Bottom hint */}
              <Paper
                px="md"
                py="sm"
                radius="md"
                bg="var(--mantine-color-dark-7)"
                withBorder
              >
                <Group gap="xs">
                  <IconSparkles size={15} />
                  <Text size="xs" c="dimmed">
                    Everything here is private to your personal library.
                  </Text>
                </Group>
              </Paper>
            </Stack>
          </Grid.Col>
        </Grid>
      </Container>
    </Box>
  )
}

const SectionHeader = ({
  icon,
  title,
  description,
}: {
  icon?: React.ReactNode
  title: string
  description: string
}) => {
  return (
    <Group gap="sm" mb="lg" align="flex-start">
      {icon && (
        <ActionIcon
          variant="light"
          size={34}
          radius="sm"
          style={{ pointerEvents: 'none' }}
        >
          {icon}
        </ActionIcon>
      )}

      <Box>
        <Text fw={700} size="md">
          {title}
        </Text>

        <Text size="xs" c="dimmed" mt={2}>
          {description}
        </Text>
      </Box>
    </Group>
  )
}

const TagInput = ({
  label,
  placeholder,
}: {
  label: string
  placeholder: string
}) => {
  return (
    <Input.Wrapper label={label}>
      <Flex gap="xs">
        <Input placeholder={placeholder} style={{ flex: 1 }} />
        <ActionIcon
          size={36}
          variant="light"
          aria-label={`Add ${label}`}
        >
          <IconPlus size={17} />
        </ActionIcon>
      </Flex>
    </Input.Wrapper>
  )
}

export default AddTvShow
