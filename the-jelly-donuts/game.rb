require 'midilib/sequence'
require 'midilib/consts'
include MIDI

class Game
  def initialize(number)
    @number = number
    `say "the number is #{@number}"`
    puts number
  end

  def find_next
    if @number == 1
      system('say "Thank you, ladies and gentlemen"')
      return 1
    end

    mod = @number % 3
    if mod == 0
      prettify(@number, :/, 3)
      @number /= 3
    elsif mod == 2
      prettify(@number, :+, 1)
      @number += 1
    else
      prettify(@number, :-, 1)
      @number -= 1
    end

    note = (@number % 64) + 64
    play_it note

    find_next
  end

  def prettify(initial, operation, operand)
    puts "#{initial} #{operation} #{operand} = #{initial.send(operation, operand)}"
  end

  def play_it(note)
    seq = Sequence.new()

    # Create a first track for the sequence. This holds tempo events and stuff
    # like that.
    track = Track.new(seq)
    seq.tracks << track
    track.events << Tempo.new(Tempo.bpm_to_mpq(120))
    track.events << MetaEvent.new(META_SEQ_NAME, 'Sequence Name')

    # Give the track a name and an instrument name (optional).
    track.name = 'My New Track'
    track.instrument = GM_PATCH_NAMES[0]

    # Add a volume controller event (optional).
    track.events << Controller.new(0, CC_VOLUME, 127)

    # Add events to the track: a major scale. Arguments for note on and note off
    # constructors are channel, note, velocity, and delta_time. Channel numbers
    # start at zero. We use the new Sequence#note_to_delta method to get the
    # delta time length of a single quarter note.
    track.events << ProgramChange.new(0, 1, 0)

    quarter_note_length = seq.note_to_delta('quarter')

    track.events << NoteOn.new(0, note, 127, 0)
    track.events << NoteOff.new(0, note, 127, quarter_note_length)

    File.open('jelly_donut.mid', 'wb') { |file| seq.write(file) }
    system("fluidsynth -i FluidR3GM2-2.SF2 jelly_donut.mid > /dev/null 2> /dev/null")
  end

end
