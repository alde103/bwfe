defmodule MixMusic.NotePlayer do
  @moduledoc """
  Plays a Note
  """
  alias MixMusic.Note
  require Logger

  def play(
        %Note{duration: duration, volume: volume} =
          note
      ) do
    frequency = Note.to_frequency(note)
    Logger.info("Played Note: #{note.class} #{note.modifier} #{note.octet}")

    system_cmd = """
    echo 'foo' | awk '{ for (i = 0; i < #{duration}; i+= 0.00003125) \
    printf("%08X\\n", #{volume}*sin(#{frequency}*3.14*exp((a[$1 % 8]/12)\
    *log(2))*i)) }' | xxd -r -p | aplay -c 2 -f S32_LE -r 28000
    """

    Logger.debug("executing: #{system_cmd}")

    cmd(system_cmd)
  end

  defp cmd(string) do
    case System.cmd("sh", ["-c", string], stderr_to_stdout: true, into: IO.stream(:stdio, :line)) do
      {_, 0} -> :ok
      _ -> :error
    end
  end
end
